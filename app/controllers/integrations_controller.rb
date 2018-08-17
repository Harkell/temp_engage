class IntegrationsController < ApplicationController
  require 'google/apis/sheets_v4'
  require 'google/apis/drive_v2'
  require 'googleauth'
  require 'googleauth/stores/file_token_store'
  require 'fileutils'

  def index
  end

  def googlesheets #auths the user
  	client_secrets = Google::APIClient::ClientSecrets.load("#{Rails.root}/config/client_secrets.json")
  	@auth_client = client_secrets.to_authorization
	@auth_client.update!(
		#:scope => 'https://www.googleapis.com/auth/spreadsheets.readonly',
		:scope => 'https://www.googleapis.com/auth/drive.readonly', #CHANGE THIS DEPENDING ON PURPOSE
		:redirect_uri => 'http://localhost:3000/integrations/googlesheetsimport',
		:additional_parameters => {
		    "access_type" => "offline",         # offline access
		    #{}"include_granted_scopes" => "true"  # incremental auth
	  	}
	)
	auth_uri = @auth_client.authorization_uri.to_s
	redirect_to(auth_uri)
  end

  def googlesheetsimport #brings in the data
  	#client_secrets = Google::APIClient::ClientSecrets.load("#{Rails.root}/config/client_secrets.json")
  	#auth_client = client_secrets.to_authorization
	@auth_client.code = params[:code]
	@auth_client.fetch_access_token!

	service = Google::Apis::DriveV2::DriveService.new
	service.authorization = @auth_client
	files = service.list_files#(corpus: nil, max_results: nil, order_by: "lastViewedByMeDate")
	files_json = JSON.parse(files.to_json)
	@file_names = Array.new
	@file_codes = Array.new
	@files_aggregated = Hash.new
	files_json["items"].each do |n|
		if n["mimeType"] == "application/vnd.google-apps.spreadsheet"
			@file_name = n["title"]
			@file_code = n["id"]
			@files_aggregated[@file_code] = @file_name
		end
	end

	#NEED TO CLOSE WINDOW HERE




	#ALL THIS SHIT BELOW CAN READ A GOOGLE SHEET
	#service = Google::Apis::SheetsV4::SheetsService.new
	#service.authorization = auth_client


	#spreadsheet_id = '1KnAiG91cqitkLwgy0-p28O8SmN5XFcJJvrW0bERCpRY'
	#range = 'A2:A5'
	#response = service.get_spreadsheet_values(spreadsheet_id, range)
	#puts 'No data found.' if response.values.empty?
	#puts range

  end

  def specificsheetimport
	@test = params[:sheet][:id]
	@code = params[:sheet][:code]


  end


end


