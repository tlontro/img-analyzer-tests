Given(/^I at at Google Homepage$/) do
  visit('https://www.google.com/')
end

When(/^I search for "(.*?)"$/) do |query|
  google_page.query.set(query)
end

Then(/^I assert layout to be the same$/) do
  name = @scenario_name.gsub(" ","_").downcase + "_#{ENV['ENV_CONFIG']}"
  diff_image = true
  page.driver.save_screenshot("#{ENV['TYPE']}_images/#{name}.png")
  if ENV['TYPE'] == 'test'
    (diff_image = ImgAnalyzer.new("#{name}.png"))
    failed_comp = "original image -> #{$project_base_path}reference_images/#{name}.png
                 \ntest image -> #{$project_base_path}test_images/#{name}.png
                 \nfailed image -> #{$project_base_path}#{diff_image.image_path}"
    raise failed_comp unless diff_image.image_path.nil?
  end
end
