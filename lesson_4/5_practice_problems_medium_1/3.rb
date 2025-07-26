class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end

=begin
Q: Is there anything wrong with fixing it this way?

A: Fixing it this way does not break the code and in fact makes line 10 work
as intended. However, this way of fixing it introduces risks. The original code
only initialized a reader, product_name, for @product_name. If we do not pass
:quantity alone to attr_accessor but both, we also initialize a setter for
@product_name unintentionally. With this unintended setter, it becomes possible
to change the value of @product_name unintentionally.

CORRECTION
My analysis is technically not wrong but it missed the point of the question.
=end

=begin
OFFICIAL SOLUTION
Nothing incorrect syntactically. However, you are altering the public
interfaces of the class. In other words, you are now allowing clients of the
class to change the quantity directly (calling the accessor with
instance.quantity = <new value>), rather than by going through the
update_quantity method. It means that the protections built into the
update_quantity method can now be circumvented and potentially pose problems
down the line.
=end
