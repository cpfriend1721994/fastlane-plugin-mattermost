# mattermost plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-mattermost)

## Getting Started

1. Generate `Mattermost Incoming Webhook`
    - From your Mattermost organization page, go to `Integrations` -> `Incoming Webhooks` -> `Add Incoming Webhooks`
    - Configurate Incoming Webhooks
    - Get Webhooks URL

2. Add plugin to `fastlane`

```bash
fastlane add_plugin mattermost
```

3. Add `mattermost` to your lane in `Fastfile` whenever you want to upload the file

```bash
lane :build_android do

    ...

    # Push messages to Mattermost
    mattermost(
                url: "https://example.mattermost.com/hooks/xxx-generatedkey-xxx",
                params: "Hello, this is some text\nThis is more text. :tada:"
              )
```

## About mattermost

Fastlane plugin for push messages to Mattermost

**Note to author:** Add a more detailed description about this plugin here. If your plugin contains multiple actions, make sure to mention them here.

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

**Note to author:** Please set up a sample project to make it easy for users to explore what your plugin does. Provide everything that is necessary to try out the plugin in this project (including a sample Xcode/Android project if necessary)

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
