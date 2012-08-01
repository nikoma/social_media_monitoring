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
  $client = SocialMediaMonitoring::Client.new("987634f072b7c51db349bda9fd5cd6da")

  def test_keywords
    VCR.use_cassette('keywords') do
      response = $client.keywords.response.first.name
      assert_match /berliner bubbletea/, response
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
end