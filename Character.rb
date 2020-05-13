# TODO Give a Character additional capabilities like state, position, behaviour ... whatever 
class Character < Thing
  def initialize(name, description, type)
    super(name,description)
    @type=type
  end

  def to_s
    "Character type #{@type} is #{super.to_s}"
  end
  attr_accessor :value
end
  
