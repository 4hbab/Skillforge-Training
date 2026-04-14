# db/seeds.rb
puts "🌱 Seeding SkillForge Training Users..."

# ── Users ─────────────────────────────────────────────────────────────────────
admin = User.find_or_create_by!(email: "admin@skillforge.dev") do |u|
  u.name     = "Alex Admin"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role     = :admin
end
puts "  ✅ Admin:      #{admin.email}"

instructor = User.find_or_create_by!(email: "instructor@skillforge.dev") do |u|
  u.name     = "Prof. Morgan"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role     = :instructor
end
puts "  ✅ Instructor: #{instructor.email}"

learner = User.find_or_create_by!(email: "learner@skillforge.dev") do |u|
  u.name     = "Sam Learner"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.role     = :learner
end
puts "  ✅ Learner:    #{learner.email}"

puts ""
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "  Credentials (all: password123):"
puts "  Admin:       admin@skillforge.dev"
puts "  Instructor:  instructor@skillforge.dev"
puts "  Learner:     learner@skillforge.dev"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
