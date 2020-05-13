class Thing
  def initialize(name, description)
    @name = name
    @description = description
    # HACK using "" for objects without or unknown state is not nice --> refactor in separate classes
    @state = ""
  end

  def to_s
    "Thing #{@name} is #{@description}" 
  end
  
  def state_is(which)
    return @state.eql? which
  end
  
  attr_accessor :name, :description, :state
end

