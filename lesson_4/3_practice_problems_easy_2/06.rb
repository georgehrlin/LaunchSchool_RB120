class Television
  def self.manufacturer # This is defining a class method because self is part
    # method logic      # of the definition header. When self is outside of the
  end                   # body of an instance method, it always refers to the
                        # class

  def model             # This is defining an instance method. Defining a
    # method logic      # method in a class without a prefix of self always
  end                   # defines an instance method
end

Television.manufacturer # This is how to call ::manufacturer
Television.new.model    # This is how to call #model
