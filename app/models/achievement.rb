class Achievement < ApplicationRecord

  # Associations
  belongs_to :user, optional: true

  # Validations
  validates :title, presence: true
  validates :user, presence: true
  validates :title, uniqueness: {
    scope: :user_id,
    message: "You can't have two achievements with the same title"
  }


  enum privacy: [
    :public_access,
    :private_access,
    :friends_access
  ]

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end

end
