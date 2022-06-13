# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Rails.logger.debug 'Seeding your database...'

User.create(email: 'test@test.com', password: '123123')

organization = Organization.create(name: 'Test Org')

10.times do |project|
  project = Project.create(organization_id: organization.id, name: "Project #{project}")

  5.times do |task|
    Task.create(name: "Task #{task}", description: "Description #{task}", project_id: project.id)
  end
end

Rails.logger.debug 'Your database is seeded!'
