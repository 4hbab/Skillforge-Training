class User < ApplicationRecord
  # ─────────────────────────────────────────────────────────────────────────────
  # Devise Modules
  # ─────────────────────────────────────────────────────────────────────────────
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ─────────────────────────────────────────────────────────────────────────────
  # Role Enum
  # ─────────────────────────────────────────────────────────────────────────────
  enum :role, { learner: 0, instructor: 1, admin: 2 }, default: :learner

  # ─────────────────────────────────────────────────────────────────────────────
  # Explicit Named Scopes
  # ─────────────────────────────────────────────────────────────────────────────
  scope :admins,      -> { where(role: roles[:admin]) }
  scope :instructors, -> { where(role: roles[:instructor]) }
  scope :learners,    -> { where(role: roles[:learner]) }

  # ─────────────────────────────────────────────────────────────────────────────
  # Validations
  # ─────────────────────────────────────────────────────────────────────────────
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  # Convenience Helpers
  # ─────────────────────────────────────────────────────────────────────────────
  def display_name
    name.presence || email.split("@").first.humanize
  end

  def role_label
    role.humanize.capitalize
  end
end
