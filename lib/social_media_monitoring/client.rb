module SocialMediaMonitoring
  class Client
    include HTTParty
    base_uri 'https://api.apphera.com/1'
    format :json
    
    attr_reader :api_key
    
    # Get a free api_key @ http://developer.apphera.com/sign_up
    def initialize(api_key=nil)
      @api_key = api_key
      @api_key ||= SocialMediaMonitoring.api_key     
      @api_path = ''

    end
    
    def sentiment(body, lang)
      options = { :body => { :body => body, :lang => lang }, :query => self.default_options}
      results = self.class.post('/sentiments', options)    
      results
    end
    
    def keywords
      results = Mash.new(self.class.get('/keywords', :query => self.default_options))
    end
    
    def create_keyword(keyword)
      options = { :body => { :keyword => keyword }, :query => self.default_options}
      self.class.post('/keywords/create', options)
    end
    
    def show_keyword(id)
      options = { :query => self.default_options }
      self.class.get("/keywords/#{id}", options)
    end

    
    protected
    
      def default_options
        {:api_key => @api_key}
      end
      
  end
end