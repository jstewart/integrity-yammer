require 'rubygems'
require 'integrity'
require 'yammer4r'

module Integrity
  class Notifier
    class Yammer < Notifier::Base

      attr_reader :config

      def initialize(build, config = {})
        @yammer_client = ::Yammer::Client.new(:config => config['oauth_yml']) 
        super
      end
      
      def self.to_haml
        File.read File.dirname(__FILE__) / "config.haml"
      end

      def deliver!
        @yammer_client.message(:post, :body => message)
      end

      def message
        @message ||= "#{build.project.name} #{short_message}"
      end
    end
  end
end
