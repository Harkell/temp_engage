class InternalController < ApplicationController
	require 'google/apis/drive_v2'
	require 'google/api_client/client_secrets'

  def control
  	unless current_user
    	redirect_to new_user_session_path, notice: "Please log in."
  	end

	#sheets = spreadsheets.list_files
	#auth_client.code = params[:code]
	#auth_client.fetch_access_token!

  end





end
