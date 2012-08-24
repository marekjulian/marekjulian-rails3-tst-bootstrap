# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
roles = Role.create!([ { :name => 'admin'},
                       { :name => 'archive_owner'},
                       { :name => 'archive_member'},
                       { :name => 'visitor'}
])
User.create(email: "marek@marekjulian.com", username: "marekjulian", firstname: "Marek Julian", lastname: "Ryniejski", password: "", password_confirmation: "",
            :roles => Role.where(:name => ['admin', 'archive_owner']))
