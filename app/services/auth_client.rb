require "singleton"

class AuthClient
  include Singleton

  def self.oauth_client
    OAuth2::Client.new(
      ENV['base_client_id'],
      ENV['base_client_secret'],
      site: 'https://api.getbase.com',
      authorize_url: '/oauth2/authorize',
      token_url: '/oauth2/token'
    )
  end

  def self.refresh_token(organization)
    body = {
      "grant_type" => "refresh_token",
      "refresh_token" => "#{organization.refresh_token}"
    }
    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Basic #{ENV['base_client_id']}:#{ENV['base_client_secret']}}"
    }
    response = RestClient::Request.execute method: :post, url: "https://api.getbase.com/oauth2/token",
                                           payload: body.to_json, headers: headers
    parsed_response = JSON.parse(response)
    organization.update(
      oauth_token: parsed_response['access_token'],
      refresh_token: parsed_response['refresh_token']
    )
  end
end
