require "spec_helper"

describe AuthClient do
  describe '#oauth_client' do
    it "generates the oauth client" do
      expect(AuthClient.oauth_client).to be_a OAuth2::Client
    end
  end
end
