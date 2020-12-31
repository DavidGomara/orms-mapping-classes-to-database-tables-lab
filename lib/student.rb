class Student

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
  end 

  def self.create_table

    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    );
    SQL

    DB[:conn].execute(sql)
  end 

  def self.drop_table

    sql = <<-SQL
    DROP TABLE IF EXISTS students;
    SQL

    DB[:conn].execute(sql)
  end 

  def save 

    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?,?);
    SQL

    DB[:conn].execute(sql,self.name,self.grade)

    sql_2 = <<-SQL
    SELECT id
    FROM students
    ORDER BY id DESC
    LIMIT 1;
    SQL

    student_id = DB[:conn].execute(sql_2)
    @id = student_id[0][0]
  end 

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end 

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
