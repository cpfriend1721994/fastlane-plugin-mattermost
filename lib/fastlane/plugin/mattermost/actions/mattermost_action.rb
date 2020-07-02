require 'fastlane/action'
require_relative '../helper/mattermost_helper'

DEFAULT_USERNAME = "Fastlane Mattermost"
DEFAULT_ICON_URL = "https://www.mattermost.org/wp-content/uploads/2016/04/icon.png"

def is_blank? variable
  str_variable = variable
  str_variable = variable.strip if variable.class.to_s == "String"
  str_variable.nil? || str_variable.empty?
end

module Fastlane
  module Actions
    class MattermostAction < Action
      def self.run(params)

        require 'net/http'
        require 'uri'
        require 'json'

        begin
          uri = URI.parse(params[:url])
          header = {
            'Content-Type': 'application/json'
          }
          body = {
            'text': params[:text],
            'username': (is_blank?(params[:username]) ? DEFAULT_USERNAME : params[:username]),
            'icon_url': (is_blank?(params[:icon_url]) ? DEFAULT_ICON_URL : params[:icon_url])
          }
          body.merge!('channel': params[:channel]) if is_blank?(params[:channel])
          body.merge!('icon_emoji': params[:icon_emoji]) if is_blank?(params[:icon_emoji])
          body.merge!('attachments': params[:attachments]) if is_blank?(params[:attachments])
          body.merge!('props': params[:props]) if is_blank?(params[:props])
          body.merge!('type': params[:type]) if is_blank?(params[:type])
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = (uri.scheme == 'https')
          request = Net::HTTP::Post.new(uri.request_uri, header)
          request.body = body.to_json
          response = http.request(request)
        rescue => exception
          UI.error("Exception: #{exception}")
        ensure
          UI.success('Successfully push messages to Mattermost')
        end
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
          FastlaneCore::ConfigItem.new(key: :url,
                                       env_name: "MATTERMOST_WEBHOOKS_URL",
                                       sensitive: true,
                                       description: "Mattermost Incoming Webhooks URL"),
          FastlaneCore::ConfigItem.new(key: :text,
                                       env_name: "MATTERMOST_WEBHOOKS_PARAMS",
                                       description: "Mattermost Incoming Webhooks Params"),
          FastlaneCore::ConfigItem.new(key: :username,
                                       env_name: "MATTERMOST_WEBHOOKS_USERNAME",
                                       optional: true,
                                       description: "Mattermost Incoming Webhooks Username"),
          FastlaneCore::ConfigItem.new(key: :icon_url,
                                       env_name: "MATTERMOST_WEBHOOKS_ICON_URL",
                                       optional: true,
                                       description: "Mattermost Incoming Webhooks Icon URL"),
          FastlaneCore::ConfigItem.new(key: :channel,
                                       env_name: "MATTERMOST_WEBHOOKS_CHANNEL",
                                       optional: true,
                                       description: "Mattermost Incoming Webhooks Channel"),
          FastlaneCore::ConfigItem.new(key: :icon_emoji,
                                       env_name: "MATTERMOST_WEBHOOKS_ICON_EMOJI",
                                       optional: true,
                                       description: "Mattermost Incoming Webhooks Icon Emoji"),
          FastlaneCore::ConfigItem.new(key: :attachments,
                                       env_name: "MATTERMOST_WEBHOOKS_ATTACHMENTS",
                                       optional: true,
                                       description: "Mattermost Incoming Webhooks Attachments"),
          FastlaneCore::ConfigItem.new(key: :props,
                                       env_name: "MATTERMOST_WEBHOOKS_PROPS",
                                       optional: true,
                                       description: "Mattermost Incoming Webhooks Properties"),
          FastlaneCore::ConfigItem.new(key: :type,
                                       env_name: "MATTERMOST_WEBHOOKS_TYPE",
                                       optional: true,
                                       description: "Mattermost Incoming Webhooks Type")
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
            url: "https://example.mattermost.com/hooks/xxx-generatedkey-xxx",
            text: "Hello, this is some text\nThis is more text. :tada:",
            username: "Fastlane Mattermost",
            icon_url: "https://www.mattermost.org/wp-content/uploads/2016/04/icon.png"
          )',
          'mattermost(
            url: "https://example.mattermost.com/hooks/xxx-generatedkey-xxx",
            text: "Hello, this is some text\nThis is more text. :tada:",
            username: "Fastlane Mattermost",
            icon_url: "https://www.mattermost.org/wp-content/uploads/2016/04/icon.png",
            channel: ... ,
            icon_emoji: ... ,
            attachments: ... ,
            props: ... ,
            type: ...
          )'
        ]
      end
    end
  end
end
