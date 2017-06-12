class NewAchievementForm

  include Capybara::DSL

  #
  # Visit Page
  def visit_page
    visit '/'
    click_on 'New Achievement'
    self
  end

  #
  # Fill in the form
  def fill_in_with(params = {})
    fill_in('Title', with: params.fetch(:title, 'Read a Book'))
    fill_in('Description', with: 'Lorem Ipsum Dolor')
    select('Public', from: 'Privacy')
    check('Featured')
    attach_file('Cover image', "#{Rails.root}/spec/fixtures/cover_image.png")
    self
  end

  #
  # Submit the form
  def submit
    click_on('Create Achievement')
  end

end