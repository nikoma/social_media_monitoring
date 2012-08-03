module SocialMediaMonitoring
  class Client
    include HTTParty
    base_uri 'https://api.apphera.com/1'
    format :json

    attr_reader :api_key
    #curl -G -d "&api_key=638955fa280854f29a8b42b54cb1625e&country=de&cat_id=135&geo=53.66,10.1154" https://api.apphera.com/1/organizations
    # Get a free api_key @ https://developer.apphera.com
    def initialize(api_key=nil)
      @api_key = api_key
      @api_key ||= SocialMediaMonitoring.api_key
      @api_path = ''

    end
    def categories(country)
      results = Mash.new(self.class.get('/categories', :query => {:country => country}.merge(self.default_options)))
    end
    
    
    def keywords
      results = Mash.new(self.class.get('/keywords', :query => self.default_options))
    end

    def create_keyword(keyword)
      options = {:body => {:keyword => keyword}, :query => self.default_options}
      results = Mash.new(self.class.post('/keywords/create', options))
    end

    def show_keyword(id)
      options = {:query => self.default_options}
      results = Mash.new(self.class.get("/keywords/#{id}", options))
    end

    def sentiment(body, lang)
      options = {:body => {:body => body, :lang => lang}, :query => self.default_options}
      results = Mash.new(self.class.post('/sentiments', options))
    end
    
    def competitors(cat_id, geo)
      options = {:query => {:cat_id => cat_id, :geo => geo}.merge(self.default_options)}
      results = Mash.new(self.class.get("/organizations", options))
    end
    


    protected

    def default_options
      {:api_key => @api_key}
    end

  end
end