require_relative '../../spec/support/new_achievement_form'

new_achievement_form = NewAchievementForm.new

#
#
#
Given(/^I'm a logged user$/) do
end

Given(/^Data has to be valid$/) do
  @title = 'Read a Book'
end

Given(/^I create a new achievement with the valid data$/) do
  new_achievement_form.visit_page.fill_in_with(
    title: @title
  ).submit
end

Then(/^I must see a success notice$/) do
  expect(page).to have_content 'Achievement has been created'
end

Then(/^I must see the last article$/) do
  expect(Achievement.last.title).to eq 'Read a Book'
end

#
#
#
#
Given(/^I create a new achievement with invalid data$/) do
  new_achievement_form.visit_page.submit
end

Then(/^I must see an error message for the title validation$/) do
  expect(page).to have_content "can't be blank"
end
