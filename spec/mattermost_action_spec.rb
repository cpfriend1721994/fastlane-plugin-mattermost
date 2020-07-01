describe Fastlane::Actions::MattermostAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The mattermost plugin is working!")

      Fastlane::Actions::MattermostAction.run(nil)
    end
  end
end
