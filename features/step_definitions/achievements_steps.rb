#
#
Given(/^I am a guest user$/) do
end

Given(/^there is a public achievement$/) do
  @achievement = FactoryGirl.create(:public_achievement, title: 'Just did it')
end

When(/^I go to the achievement's page$/) do
  visit(achievement_path(@achievement.id))
end

Then(/^I must see achievement's content$/) do
  expect(page).to have_content 'Just did it'
end


#
#
Given(/^Content with markdown inside$/) do
  @achievement = FactoryGirl.create(:achievement, description: 'That *was* awesome')
end

When(/^I go the achievement's page$/) do
  visit "/achievements/#{@achievement.id}"
end

Then(/^Markdown has to be converted to HTML tags$/) do
  expect(page).to have_css('em', text: 'was')
end
