module PageObjects
  class BasePage
    include Capybara::DSL
    include RSpec::Matchers

    def delete_cookies
      Capybara.current_session.driver.browser.manage.delete_all_cookies
      sleep 1
    end

    def self.element(element_name, options = {})
      define_method element_name.to_s do |*args|
        find yield(*args), options
      end
    end

    def self.elements(element_name, options = {})
      define_method element_name.to_s do |*args|
        page.all yield(*args), options
      end
    end

    def elements_between(start_element, end_element, options)
      within = options[:within] ||= 'body'
      elements = []
      collect_elements = false

      page.all("#{within} > *").each do |element|
        if element == start_element
          collect_elements = true
          next
        end
        break if element == end_element
        elements << element if collect_elements
      end

      elements
    end

    def navigate_to_site(url)
      visit(rated_people.host_url + url)
      remove_cookie_banner
      set_max_page
      set_font_smoothing_as("none")
    end

    def remove_cookie_banner
      Capybara.current_session.driver.browser.manage.add_cookie(:name => 'ratedpeople-cookie-acceptance', :value => "accepted")
      refresh
    end

    def scroll_down(ycood)
      page.execute_script "window.scrollBy(0,#{ycood})"
    end

    def set_max_page
      browser = Capybara.current_session.driver.browser
      width  = 800;
      height = browser.execute_script("return Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight);")
      # required for lazy loading
      browser.execute_script("window.scrollTo(0,document.body.scrollHeight);")
      sleep 3
      browser.manage.window.resize_to(width, height)
    end

    def text_for_elements(elements)
      elements.collect(&:text).join(' ').split.join(' ')
    end

    def wait_for_ajax
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until finished_all_ajax_requests?
      end
    end

    def set_font_smoothing_as(value)
      page.execute_script("document.querySelector('html').style.webkitFontSmoothing = '#{value}';")
    end

  end
end
