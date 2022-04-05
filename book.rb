require_relative 'rental'
class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @author = author
    @title = title
    @rentals = []
  end

  def add_rental(date, person)
    Rental.new(date, self, person)
  end
end
