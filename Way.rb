# FIXME refactor enable to class Thing 
class Way < Thing
  def initialize(direction, name, description, from, to, enable)
    @name = name
    @description = description
    @direction = direction
    # The rooms
    @from = from
    @to = to
    @enable = enable
  end

  def take()
    return to
  end
  
  def to_s
    "There is a #{@name} going #{direction}. #{@description}"
  end
  attr_accessor :name,:description, :direction, :from, :to, :enable
end

