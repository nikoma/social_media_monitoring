# Social Media Monitoring ruby gem

SocialMediaMonitoring is a collection of API methods of the Apphera API (Apphera, Inc.). At this time it offers sentiment analysis in 6 languages, keyword tracking (SERP), competitor search and review tracking from social review sites such as Qype, Yelp, Pointoo, kennstdueinen.de, tripadvisor, golocal, hotels.com, meinestadt.de, restaurant-kritik.de, wowarstdu.de etc. including reviewer information.

The API is a straight forward REST API you could use with any client like:    

curl -is -G -d  
`"&api_key=e23d80483193fddd72a2c364a72cd738&country=de&cat_id=135&geo=53.66,10.1154" https://api.apphera.com/1/organizations`
 
The API is currently in BETA. I will add more methods and documentation soon.
## Installation

Add this line to your application's Gemfile:

    gem 'social_media_monitoring'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install social_media_monitoring

## Basic usage

### Review tracking & Venues/Organizations (In BETA, GERMANY ONLY!)  

require 'social_media_monitoring'  

client = SocialMediaMonitoring::Client.new("e23d80483193fddd72a2c364a72cd738")


To receive reviews pass in the company id (from competitor search or organization search) as parameter and the id of the last review you already have received. Alternatively you can pass in 0 to receive all available reviews. 

company_id = 1234
reviews = client.reviews(1234,38644)

`=> Returns mash of available social media reviews (Qype, Yelp, Pointoo, kennstdueinen.de, tripadvisor, golocal, hotels.com, meinestadt.de, restaurant-kritik.de, wowarstdu.de etc.)`  

#### To find organizations:

organizations = client.organizations(name, postalcode, country_code)   
`=> Returns mash of organizations`

If the search does not return the organization, you can create a new record on the system which will be analyzed and then queued for processing. Germany should have already more than 85% coverage and thousands of venues are added daily. 

temporary disabled - filter rewrite & improving vetting process of data  
client.create_organization(name, street1,street2, state, postalcode, city, latitude, longitude, phone, url, facebook_page, category_id, twitter)

`=> returns confirmation`

****

### Sentiment Analysis

require 'social_media_monitoring'  

client = SocialMediaMonitoring::Client.new("e23d80483193fddd72a2c364a72cd738")

sentiment = client.sentiment("I love Ruby!","en")  
`=> <Mash response=<Mash polarity=1 sentiment=0.325>>`

or
sentiment = client.sentiment("amore","it")

`=> <Mash response=<Mash polarity=1 sentiment=0.325>>`  
The sentiment analyzer returns a Mash which you can read like this:

sentiment.response.polarity  
=> 1  
sentiment.response.sentiment  
=> 0.325

At this time the API supports the following languages:    
* English (en)  
* German (de)  
* Italian (it)  
* Spanish (es)  
* French (fr)  
* Turkish (tr)  

****

### Keyword tracking

require 'social_media_monitoring'        
client = SocialMediaMonitoring::Client.new("e23d80483193fddd72a2c364a72cd738")
  
`=> #<SocialMediaMonitoring::Client:0x007fa19422d390 @api_key="e23d80483193fddd72a2c364a72cd738", @api_path="">`  

client.create_keyword("Ruby rulez")  
`=> <Mash response=<Mash first_check="2012-07-02T23:36:32+00:00" id=553 keyword="Ruby rulez">>`

It responds with the keyword id, keyword and a date which tells you when you should expect results. The rankings will be updated frequently and
the history is stored. This allows you to track keyword positions in search results over time.

client.keywords  

`=> returns a Mash with keywords you are tracking`

client.show_keyword(553)  #id of keyword

`=> returns current and historic rankings`

The search results are paginated

You can get a free API key at https://developer.apphera.com

****

### Competitor search (In BETA, GERMANY ONLY!)  

To perform a competitor search you need to pass in the category id and the geo location as a string build from latitude and longitude.   
You can retrieve a complete list of German category by sending a query to the API.  

categories = client.categories("de")  
`=> Returns a mash of categories`

Example:  
category_id = 135  
geo = "53.66,10.1154"    

response = client.competitors(category_id, geo)

It returns a mash of companies in a radius of up to 20 miles who are competing in the same category (i.e. "dentist" or "hotel"). The results during the beta are limited to 20 companies per query. All results are ordered by distance from the geo point in miles (km = miles * 1.60934).  



********    


KNOWN ISSUE:
In case you get a `"NoMethodError: undefined method `stringify_keys' for #<HTTParty::Response:0x007fa9231ab1b0>"`
- It's telling you that the api key is invalid and therefore can't handle the server response. You can get a valid test key at [https://developer.apphera.com](https://developer.apphera.com/) .
UPDATE: It's "hotfixed" now by wrapping the calls in a rescue block and returning a clear error message.




Frequent question  
What is a Mesh?  
please visit https://github.com/intridea/hashie  


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
