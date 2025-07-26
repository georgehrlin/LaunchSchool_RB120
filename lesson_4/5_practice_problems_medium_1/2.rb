class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

=begin
update_quantity will not work as intended because quantity = updated_count is
parsed by Ruby as the initialization of a local variable quantity. The code is
intended to reassign the instance variable @quantity to updated_count. What is
missing here is the initialization of a setter method, quantity=, and to call
it properly on line 11, quantity= must be called as self.quantity = to avoid
disambiguity.
=end

# Fixed
class InvoiceEntry
  attr_writer :quantity
  attr_reader :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
    # @quantity = updated_count if updated_count >= 0 # Another option
  end
end
