class Treasure < Thing
  def initialize(name, description, value)
    super(name,description)
    @value=value
  end

  def to_s
    "Treasure worth #{@value} is #{super.to_s}"
  end
  attr_accessor :value
end
