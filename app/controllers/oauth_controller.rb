class OauthController < ApplicationController
  def request_omniauth
    return redirect_to root_url unless is_admin

    client = AuthClient.oauth_client
    redirect_to client.auth_code.authorize_url(redirect_uri: redirect_uri)
  end

  def create_omniauth
    return redirect_to root_url unless is_admin

    begin
      if params[:code].present?
        client = AuthClient.oauth_client
        token = client.auth_code.get_token(params[:code], redirect_uri: redirect_uri)

        # Update OAuth
        current_organization.update!(oauth_token: token.token, refresh_token: token.refresh_token, oauth_provider: 'basecrm')

        # Fetch company
        company = Maestrano::Connector::Rails::External.fetch_company(current_organization)
        current_organization.update!(oauth_uid: company['id'], oauth_name: company['name'], oauth_provider: 'basecrm')
      end
    rescue => e
      Maestrano::Connector::Rails::ConnectorLogger.log('warn', current_organization, "Error validating API credentials: #{e.message}, #{e.backtrace.join("\n")}")
      flash[:error] = "Cannot link account: #{e.message}"
    end

    redirect_to root_url
  end

  def destroy_omniauth
    return redirect_to root_url unless is_admin

    current_organization.clear_omniauth

    redirect_to root_url
  end

  def redirect_uri
    "#{Maestrano[current_organization.tenant].param('app_host')}/auth/baseCRM/callback"
  end
end
