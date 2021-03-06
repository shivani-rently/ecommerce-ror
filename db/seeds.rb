# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)]AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

AdminUser.create!(email: 'admin@example.com', password: 'srk@123', password_confirmation: 'srk@123') if Rails.env.development?

# Like.create([
#     {
#         user_id: 13,
#         product_id: 39
#     },
#     {
#         user_id: 13,
#         product_id: 40
#     },
#     {
#         user_id: 14,
#         product_id: 39
#     },
#     {
#         user_id: 14,
#         product_id: 40
#     }
# ])