module SocialMediaMonitoring
  class Client
    include HTTParty
    base_uri 'https://api.apphera.com/1'
    format :json

    attr_reader :api_key
    #curl -G -d -is "&api_key=ed08eba2bd5ef47bab6cb1944686fed2&country=de&cat_id=135&geo=53.66,10.1154" https://api.apphera.com/1/organizations
    # Get a free api_key @ https://developer.apphera.com
    def initialize(api_key=nil)
      @api_key = api_key
      @api_key ||= SocialMediaMonitoring.api_key
      @api_path = ''

    end
    def categories(country)
      begin
      results = Mash.new(self.class.get('/categories', :query => {:country => country}.merge(self.default_options)))
    rescue => e
      key_error e
    end
    end
    
    
    def keywords
      begin
      results = Mash.new(self.class.get('/keywords', :query => self.default_options))
    rescue => e
      key_error e
    end
    end

    def create_keyword(keyword)
      options = {:body => {:keyword => keyword}, :query => self.default_options}
      begin
      results = Mash.new(self.class.post('/keywords/create', options))
    rescue => e
      key_error e
    end
    end

    def show_keyword(id)
      options = {:query => self.default_options}
      begin
      results = Mash.new(self.class.get("/keywords/#{id}", options))
    rescue => e
      key_error e
    end
    end

    def sentiment(body, lang)
      options = {:body => {:body => body, :lang => lang}, :query => self.default_options}
      begin
      results = Mash.new(self.class.post('/sentiments', options))
    rescue => e
      key_error e
    end
    end
    
    def competitors(cat_id, geo)
      options = {:query => {:cat_id => cat_id, :geo => geo}.merge(self.default_options)}
      begin
        results = Mash.new(self.class.get("/organizations", options))
      rescue => e
        key_error e 
        
      end
    end
    
    def reviews(organization_id, review_id=0)
      options = {:query => {:organization_id => organization_id, :review_id => review_id}.merge(self.default_options)}
      begin
        results = Mash.new(self.class.get("/reviews", options))  
      rescue => e
        key_error e 
      end    
    end
    def key_error(mes)
      "Invalid key or no Internet connection. Please obtain a free API key at https://developer.apphera.com or try one of the public keys from https://github.com/nikoma/social_media_monitoring, the complete error message is: #{mes}"
    end


    protected

    def default_options
      {:api_key => @api_key}
    end

  end
end