require 'rubygems'
require 'test/unit'
require 'vcr'
require 'webmock'
require 'social_media_monitoring'


VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock

end

class VCRTest < Test::Unit::TestCase
  $client = SocialMediaMonitoring::Client.new("63ad4581c8746c06b511b3fe50f4ace5")

  def test_keywords
    VCR.use_cassette('keywords') do
      response = $client.keywords.response.first.name
      assert_match /ruby testing/, response
    end
  end

  def test_create_keyword
    VCR.use_cassette('create_keyword') do
      keyword = "ruby testing"
      response = $client.create_keyword(keyword).response.keyword
      assert_match keyword, response
    end
  end

  def test_show_keyword
    VCR.use_cassette('show_keyword') do
      keyword_id = 550
      response = $client.show_keyword(keyword_id).first[1][0].keyword
      assert_match /berliner bubbletea/, response
    end
  end

  def test_sentiment
    VCR.use_cassette('sentiment') do
      sample = "I love ruby"
      response = $client.sentiment(sample, "en").response.polarity
      assert_equal 1, response.to_i
    end
  end

  def test_categories_de
    VCR.use_cassette('categories_de') do
      response = $client.categories("de").response
      # assert_equal 1, response.to_i
    end
  end

  def test_competitors_de
    VCR.use_cassette('competitors_de') do
      category_id = 135
      geo = "53.66,10.1154"
      response = $client.competitors(category_id, geo).response.first.id
      assert_equal 282, response.to_i
    end
  end
  def test_reviews_de
    VCR.use_cassette('reviews_de') do
      organization_id = 282
      response = $client.reviews(organization_id,0).response.first.id
      assert_equal 5938, response.to_i
    end
  end
  def test_wrong_key
     VCR.use_cassette('wrong_key') do
       client = SocialMediaMonitoring::Client.new("wrong_key_3423423423khkjhk3")
       response = client.reviews(282,0)
       assert_match /Please obtain/, response
     end
   end
end