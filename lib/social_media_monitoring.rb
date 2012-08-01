require 'rubygems'
gem 'mash'
require 'mash'
gem 'httparty'
require 'httparty'


class APIKeyNotSet   < StandardError; end

module SocialMediaMonitoring
  
  # Get your API key from https://developer.apphera.com
  def self.api_key
    raise APIKeyNotSet if @api_key.nil?
    @api_key
  end
  
  def self.api_key=(api_key)
    @api_key = api_key
  end
  
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'social_media_monitoring', 'client')