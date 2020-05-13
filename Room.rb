# FIXME refactor enable to class Thing 
class Room < Thing
  def initialize(name,description,enable)
    super(name,description)
    @ways = Hash.new
    @items = Hash.new
    @enable = enable
  end
  
  def to_s
    "You are in the #{@name}."
  end
  attr_accessor :value,:ways,:items, :enable
end

