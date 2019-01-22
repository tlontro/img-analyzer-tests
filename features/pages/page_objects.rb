require_relative 'base_page'

module Pages

  def google_page
    @google_page ||= PageObjects::GooglePage.new
  end

end

World(Pages)
