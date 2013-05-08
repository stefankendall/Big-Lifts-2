Then(/^The "(.*?)" segment is selected$/) do |text|
  selected_index = frankly_map("view:'UISegmentedControl'", "selectedSegmentIndex")[0]
  selected_text = frankly_map("view:'UISegmentedControl'", "titleForSegmentAtIndex:", selected_index)[0]
  selected_text.should == text
end
