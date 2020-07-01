require 'fastlane/action'
require_relative '../helper/mattermost_helper'

module Fastlane
  module Actions
    class MattermostAction < Action
      def self.run(params)

        require 'net/http'
        require 'uri'
        require 'json'

        uri = URI.parse(params[:uri] || MATTERMOST_WEBHOOKS_URL)
        header = {
          'Content-Type': 'application/json'
        }
        body = {
          'text': (params[:params] || MATTERMOST_WEBHOOKS_PARAMS)
        }
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == 'https')
        request = Net::HTTP::Post.new(uri.request_uri, header)
        request.body = body.to_json
        response = http.request(request)

      end

      def self.description
        "Fastlane plugin for push messages to Mattermost"
      end

      def self.authors
        ["cpfriend1721994"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Fastlane plugin for push messages to Mattermost"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :mattermost_webhooks_url,
                                       env_name: "MATTERMOST_WEBHOOKS_URL",
                                       sensitive: true,
                                       description: "Mattermost Incoming Webhooks URL"),
          FastlaneCore::ConfigItem.new(key: :mattermost_webhooks_params,
                                       env_name: "MATTERMOST_WEBHOOKS_PARAMS",
                                       description: "Mattermost Incoming Webhooks Params")
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end

      def self.example_code
        [
          'mattermost(
            uri: "https://example.mattermost.com/hooks/xxx-generatedkey-xxx",
            params: "Hello, this is some text\nThis is more text. :tada:"
          )'
        ]
      end
    end
  end
end
