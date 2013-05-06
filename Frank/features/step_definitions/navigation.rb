When(/^I tap the navigation icon$/) do
  touch "view:'UIImageView' marked:'ButtonMenu.png'"
  wait_for_nothing_to_be_animating
end