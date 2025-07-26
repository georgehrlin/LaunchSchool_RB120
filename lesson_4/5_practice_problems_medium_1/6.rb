=begin
A: The only difference between the first and second code snippets is on line 9.

With the first code snippet, when the instance method show_template is called
on an instance of Computer, the getter template is executed. It then returns
the value of the instance variable @tempalte, which is "template 14231".

On the other hand, with the second code snippet, when this version of
show_tempalte is called on an instance of Computer, effectively the same thing
happens despite the addition of self. The getter method template is also called
on the instance, retrieving the value of @template and returning
"template 14231". This is because self refers to the object itself when it is
inside the body of an instance method.
=end

=begin
NOTES
The general rule from the Ruby Style Guide is to "Avoid self where not
required."
=end
