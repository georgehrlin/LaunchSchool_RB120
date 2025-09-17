module Supervisable
  def supervise; end
end

class Preschool
  def initialize
    @attendees = []
  end

  def <<(attendee)
    @attendees << attendee
  end
end

class Person
  def initailize

  end

  def eat_lunch; end
end

class Child < Person
  attr_writer :confused

  def initailize
    @confused = true
  end

  def learn; end

  def play; end
end

class TeachingStaff < Person
  def help_schoolwork(child)
    child.confused = false
  end

  def watch_on_playground; end
end

class Teacher < TeachingStaff
  include Supervisable

  def teach; end
end

class ClassAssistant < TeachingStaff
  def help_bathroom_emergencies
  end
end

class Principal < Person
  include Supervisable

  def expel; end
end

class LogisticalStaff < Person; end

class Janitor < LogisticalStaff
  def clean; end
end

class CafeteriaWorker < LogisticalStaff
  def serve_food; end
end
