require_relative 'person'
require_relative 'student'
require_relative 'book'
require_relative 'classroom'
require_relative 'teacher'
require_relative 'rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def console_entry_point
    puts 'Welcome to my School Library!'
    until list_of_options
      input = gets.chomp
      if input == '7'
        puts 'Thank You for using my School Library!'
        break
      end

      option input
    end
  end

  def list_all_books
    puts 'no books found! Add a book' if @books.empty?
    @books.each_with_index { |book, index| puts "#{index} - #{book.title} - Author: #{book.author}" }
  end

  def list_all_people
    puts 'no people found! Add a person' if @books.empty?
    @people.each { |person| puts "#{person.id} - #{person.name} - Age: #{person.age}" }
  end

  def create_person
    puts 'To create a student, press 1, to create a teacher, press 2 : '
    option = gets.chomp
    case option
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'invalid input'
    end
  end

  def create_student
    puts 'create student '
    print 'enter student name: '
    name = gets.chomp
    print 'enter student age: '
    age = gets.chomp
    age.to_i
    print 'Has parental permission [y/n]: '
    permission = gets.chomp.to_s.upcase
    case permission
    when 'Y'
      student = Student.new(age, name, true)
      @people << student
      puts 'Student created successful'
    when 'N'
      student = Student.new(age, name, false)
      @people << student
      puts 'Student created successful'
    else
      puts 'invalid input'
    end
  end

  def create_teacher
    puts 'create a teacher '
    print 'enter teacher\'s name: '
    name = gets.chomp
    print 'enter teacher age: '
    age = gets.chomp
    age.to_i
    puts 'specialization'
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    @people << teacher
    puts 'teacher created successful'
  end

  def create_book
    puts 'create book'
    puts 'enter book title'
    title = gets.chomp
    puts 'enter author'
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts 'Book successfully created'
  end

  def create_rental
    puts 'Select which book you want to rent by entering its number'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book_id = gets.chomp.to_i
    puts 'Select a person from the list by its number'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_id = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp.to_s
    rental = Rental.new(date, @books[book_id], @people[person_id])
    @rentals << rental
    puts 'Rental created successfully'
  end

  def list_all_rentals
    print 'see person rentals enter the person ID: '
    id = gets.chomp.to_i
    puts 'Rented Books: '
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book '#{rental.book.title}' author #{rental.book.author}" if rental.person.id == id
    end
  end
end
