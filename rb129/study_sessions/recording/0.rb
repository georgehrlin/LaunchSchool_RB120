=begin
Nouns:
preschool, child, teacher, class assistant, principal, janitor,
cafeteria worker

Verbs:
help with schoolwork, watch on playground, teach, help with bathroom, learn,
play, supervise a class, expel, clean, serve food, eat lunch

Nouns and verbs:
- Child
  - learn
  - play
  - eat_lunch

- Teacher
  - help_schoolwork
  - watch_on_playground
  - teach
  - supervise
  - eat_lunch

- Class assistant
  - help_schoolwork
  - watch_on_playground
  - help_bathroom_emergencies
  - eat_lunch

- Principal
  - supervise
  - expel
  - eat_lunch

- Janitor
  - clean
  - eat_lunch

- Cafeteria worker
  - serve_food
  - eat_lunch
=end

module Supervisable
  def supervise; end
end

class Preschool; end

class Person < PreSc
  def eat_lunch; end
end

class Child < Person
  def learn; end

  def play; end
end

class TeachingStaff < Person
  def help_schoolwork; end

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
