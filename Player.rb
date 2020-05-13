
class Player
  def initialize(game, startposition)
    @game = game
    @points = 0
    @items = Array.new
    @position = startposition # The name(!) of the room where I am
    @room = @game.rooms[@position] # The room (!) where I am
  end
  attr_accessor :room,:points
  
  def take_way(w)
    @position = w.to.name
    @room = @game.rooms[@position]
    print "You're in the " + @position + "\n"
    print @room.description + "\n"
  end
  
def move(direction)
  if (@room.ways[direction].nil?)
    puts "No way #{direction}"
  else
    take_way(@room.ways[direction])
  end
end

def take (thing)
  if (@room.items[thing].nil?)
    puts "There is no #{thing}"
  else
    items << @room.items.delete(thing)
  end
end

def switch(phrase)
  # eg "switch on lamp" 
  parts = phrase.split
  state = parts[0]
  what = parts.drop(1).join(" ")
  item = @items.detect{|i| i.name.eql? what}
  item.state = state unless item.nil?
end

def show_everything(direction)
  # show the things in a room/place
  # part of "look", which checks, if things are visible in the room, and if, it shows everything
  if (direction == "around")
    # show ways
    @room.ways.each {|dir,way|
      # HACK put the logic to a better (other ;-) place
      if (way.enable.nil?)
        # if they are enabled
        puts "There is a #{way.name} going #{way.direction}"
      else
        rule = way.enable.split
        # "enable" clause for ways
        # this checks, if I have an object, like "has carpet"
        if rule[0].eql? "has"
          object = rule[1]
          if has(object)
            puts "There is a #{way.name} going #{way.direction}"
          end
        end  
      end
      }
      # show items
      @room.items.each {|n,i|
      puts "A #{i.name} is lying on the floor"
      }
  else
    # specific direction
    # TODO handle that different, like "can see things further away when looking in only one direction"
    r = @room.ways[direction]
    if (r.nil?)
      puts "no way #{direction}"
    else
      p r.name
    end
  end
end

def look (direction)
  # see things and ways ... but only, if that (!) is possible, eg if light is on ...
  if (@room.enable)
    rule = @room.enable.split
    if rule[0].eql? "on"
      thing_name = rule.drop(1).join(" ")
      the_thing = @items.detect{|i| i.name.eql? thing_name}
      if the_thing.state_is("on")
        show_everything(direction)
      end
    end
  else
    show_everything(direction)
  end
end

def show_position
  @room.to_s
end

def show_inventory
  @items.each {|i|
    if (i.state.eql? "")
      puts "#{i.name}"
    else
      puts "#{i.name} is #{i.state}"
    end
    }
end

def has(thing)
  found = items.detect{|i| i.name.eql? thing}
  return found
end

  attr_accessor :position, :items
  attr_reader :points
end
