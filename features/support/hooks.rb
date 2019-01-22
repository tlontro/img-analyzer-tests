require 'fileutils'

Before do |scenario|
  @scenario_name = scenario.name
end

After do
  Capybara.current_session.driver.browser.manage.delete_all_cookies
  Capybara.current_session.driver.quit
end

AfterConfiguration do
  FileUtils.rm_rf('different_images', secure: true)
  FileUtils.rm_rf('test_images', secure: true)
  FileUtils.mkdir_p 'reference_images'
  FileUtils.mkdir_p 'test_images'
end
