require_relative 'person'
require_relative 'classroom'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom, name = 'Unknown')
    super(age, name, parent_permission: true)
    @classroom = classroom
    add_classroom(classroom)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def add_classroom(classroom)
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
