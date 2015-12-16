require 'json'
require 'net/http' #to make a GET request
require 'open-uri' #to fetch the data from the URL to then be parsed by JSON
class HomeController < ApplicationController


	before_action :set_auth

	@@zipcode = 98133

	def index
		uri = URI("http://search.ams.usda.gov/farmersmarkets/v1/data.svc/zipSearch?zip=#{@@zipcode}")
		res = Net::HTTP.get_response(uri)
		@markets = JSON.load(res.body)
		@markets['results'].each do |x|
			puts x['id']
		end
	end

	def set_zipcode
		@@zipcode = params[:zip_code]
		redirect_to root_url
	end

	def profile
	end

	private

	def set_auth
		@auth = session[:omniauth] if session[:omniauth]
	end
end
