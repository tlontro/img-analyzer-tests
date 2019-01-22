module CapybaraDrivers
  def self.set_driver(driver)
    case driver
    when :remote_firefox
      register_remote_firefox
    when :local_firefox
      register_local_firefox
    when :remote_chrome
      register_remote_chrome
    when :local_chrome
      register_local_chrome
    when :local_headless_chrome
      register_headless_local_chrome
    else
      raise NotImplementedError, "Driver #{driver} isn't supported."
    end
    true
  end

  private

  def self.register_remote_firefox
    Capybara.register_driver :remote_firefox do |app|
      Capybara::Selenium::Driver.new(app, browser: :remote, url: "http://#{DockerHelpers.docker_host}:#{DockerHelpers.selenium_hub_port}/wd/hub")
    end
    set_defaults(:remote_firefox)
    true
  end

  def self.register_local_firefox
    Capybara.register_driver :local_firefox do |app|
      Capybara::Selenium::Driver.new(app)
    end
    set_defaults(:local_firefox)
    true
  end

  def self.register_remote_chrome
    Capybara.register_driver :remote_chrome do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome, url: "http://#{DockerHelpers.docker_host}:#{DockerHelpers.selenium_hub_port}/wd/hub")
    end
    set_defaults(:remote_chrome)
    true
  end

  def self.register_local_chrome
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w(disable-gpu --start-maximized --start-fullscreen) }
    )
    Capybara.register_driver :local_chrome do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
    end
    set_defaults(:local_chrome)
    true
  end

  def self.register_headless_local_chrome
    Capybara.register_driver :local_headless_chrome do |app|
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        chromeOptions: { args: %w(headless disable-gpu start-maximized start-fullscreen hide-scrollbars disable-composited-antialiasing disable-font-antialiasing) }
      )

      Capybara::Selenium::Driver.new app,
        browser: :chrome,
        desired_capabilities: capabilities
    end
      Capybara.javascript_driver = :local_headless_chrome
    set_defaults(:local_headless_chrome)
    true
  end

  def self.set_defaults(driver)
    Capybara.default_driver = driver
    Capybara.default_max_wait_time = 60
  end

  def self.resize_window
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(1080, 2000)
  end
end
