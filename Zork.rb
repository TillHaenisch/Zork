require 'yaml'
require 'json'

require 'Thing'
require 'Way'
require 'Character'
require 'Room'
require 'Player'
require 'Splash'


class Game
  def splash
    Splash.splash()
  end
  
  # FIXME Create utility class with stuff like this, splash etc.
  def opposite(direction)
    op = {"south" => "north", "north" => "south", "east" => "west", "west" => "east", "down" => "up", "up" => "down"}
    return op[direction]
  end
  
  def getRoom(name)
    # return the room object with given name
    r = @rooms[name]
    if r.nil?
      # TODO: error handling, esp. errors in definition file(s)
      puts "Room #{name} not found"
    end
    return r
  end
  
  def initialize()
    # make fancy stuff (objects, hashes, lists of them) from flat (yaml) text file
    @rooms = Hash.new
    world = JSON.parse(YAML::load_file("./database.yml").to_json, object_class: OpenStruct)
    
    world.rooms.each {|room|
      r = Room.new(room.name,room.descr,room.enable)
      room.items.each{|item| r.items[item.name]=Thing.new(item.name,item.descr)} unless room.items.nil?
      @rooms[r.name]=r
    }
    
    world.ways.each {|w|
      r1 = getRoom(w.from)
      r2 = getRoom(w.to)

      # do we really need two way objects ?? maybe ways might change over time (in random fashion *hehehe*)
      one_way = Way.new(w.direction,w.name,w.description,r1,r2,w.enable)
      around = Way.new(opposite(w.direction),w.name,w.description,r2,r1,w.enable)
      r1.ways[w.direction]=one_way
      r2.ways[opposite(w.direction)]=around
    }
    @position = "Entrance to the house"
  end
  
    
  def play(player)
    @player = player
    puts @player.room
    puts @player.room.description
    loop do
      print '> '
       command = $stdin.gets
     
       case command
       when /help/
         puts "Available commands: move, north, east, west, south, up, down, look, take, quit, ?"
         puts @player.room.description
         
       when /quit/
         exit
         
       when /look (.+)/
         @player.look($1)
         
       when /take (.+)/
         @player.take($1)
         
       when /show inventory/
         @player.show_inventory
         
       when /move (.+)/
         @player.move($1)
         
       when /north|south|east|west|up|down/
         @player.move($&)
         
       when /switch (.+)/
         @player.switch($1)
         
       when /\?/
         puts @player.show_position
       else
         puts 'Unknown command'
       end     
     end    
  end
  attr_reader :rooms,:map
end


g=Game.new
p=Player.new(g,"Entrance to the house")
g.splash()
g.play(p)


