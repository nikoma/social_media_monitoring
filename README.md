# SocialMediaMonitoring

SocialMediaMonitoring is a collection of API methods of the Apphera API. At this time it offers sentiment analysis and keyword tracking for Google search rankings.
The API is currently in BETA. I will add more methods and documentation soon.
## Installation

Add this line to your application's Gemfile:

    gem 'social_media_monitoring'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install social_media_monitoring

## Basic usage

Sentiment Analysis

require 'social_media_monitoring'  

client = SocialMediaMonitoring::Client.new("987634f072b7c51db349bda9fd5cd6da")

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

Keyword tracking

require 'social_media_monitoring'      
`client = SocialMediaMonitoring::Client.new("987634f072b7c51db349bda9fd5cd6da")`
  
`=> #<SocialMediaMonitoring::Client:0x007fa19422d390 @api_key="987634f072b7c51db349bda9fd5cd6da", @api_path="">`  

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

Competitor search (In BETA, GERMANY ONLY!)  

To perform a competitor search you need to pass in the category id and the geo location as a string build from latitude and longitude.   
You can retrieve a complete list of German category by sending a query to the API.
categories = client.categories("de")  
`=> Returns a mash of categories`

Example:  
category_id = 135  
geo = "53.66,10.1154"  

response = client.competitors(category_id, geo)

It returns a mash of companies in a radius of up to 20 miles who are competing in the same category of business. The results during the beta are limited to 20 companies per query.   



KNOWN ISSUE:
In case you get a `"NoMethodError: undefined method `stringify_keys' for #<HTTParty::Response:0x007fa9231ab1b0>"`
- It's telling you that the api key is invalid and therefore can't handle the server response. Please get a valid api key. 

Frequent question  
What is a Mesh?  
please visit https://github.com/intridea/hashie  


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
