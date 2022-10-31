# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with
# db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

%w[answers assessments domains quizzes users].each do |table_name|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table_name} RESTART IDENTITY")
end

# Create Users
User.create!(email: 'kevin.luu1805@gmail.com', name: 'Kevin', password: '123123123')
User.create!(email: 'user@example.com', name: 'Tony', password: 'your_password')

# Create Domains, Quizzes and Answers
FactoryBot.create_list(:domain, 7, :with_quizzes)
