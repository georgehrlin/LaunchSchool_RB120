=begin
Q: What are the benefits of using Object Oriented Programming in Ruby? Think of
as many as you can.

A: Some of the general benefits of using OOP in Ruby that I can think of on the
top of my head:

1. Better modeling of the problem/requirements: OOP allows us to
   hierarchically model a problem and its requirements in a structure that is
   natural and similar to how the problem presents itself in reality.

2. Better organization and maintainability: Different areas of the code base
   can be organized into different parts that do not depend on each other.
   Making changes to a specific part do not cause ripple effects to other
   parts of the code base. Future additions to the code base can also be
   implemented more efficiently without changing much of the original code.

3. Better flexibility: Encapsulation, abstraction, and polymorphism, three
   pillars of OOP, enable us to customize more flexible interactions between
   data of different types via ways like inheritance and duck-typing.
=end

=begin
LSBot: To expand your thinking a bit, consider how OOP might help with code
reuse beyond just adding new parts, or how it might protect certain parts of
your code from unintended use. Also, think about how OOP might impact
collaboration between multiple developers or managing complexity as a project
grows larger.
=end

=begin
A:

4. Clearer boundaries among parts of the code base: Encapsulation allows us to
   design our own constructs and customize firm boundaries among them. This
   ensures that data will not easily be used in unintended ways. Clear
   boundaries also makes reuse easier as every part has its own distinctly
   defined features and abilities.

5. Better collaborations: When a code base is managed in intentionally defined
   parts, the clarity not only helps with everyone in a team's understanding of
   the structure of the code bsae, but also makes future collaborative efforts
   easier. For instance, when adding multiple new features, members of a team
   can work on different features separately. The new features can be packaged 
   into different new parts of the code base without making different changes
   to the original code base.
=end

=begin
OFFICIAL SOLUTION

1. Creating objects allows programmers to think more abstractly about the code
   they are writing.
2. Objects are represented by nouns so they are easier to conceptualize.
3. It allows us to only expose functionality to the parts of code that needs
   it, meaning namespace issues are much harder to come across.
4. It allows us to easily give functionality to different parts of an
   application without duplication.
5. We can build applications faster as we can resue pre-written code.
6. As the software becomees more complex, this complexity can be more easily
   managed.
=end
