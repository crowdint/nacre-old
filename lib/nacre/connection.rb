require 'faraday'

module Nacre
  class Connection
    attr_accessor :connection

    def initialize(params)
      @auth_url = params[:auth_url]
      @api_url = params[:api_url]
      @auth_data = params[:auth_data]
    end

    def authenticate
      reset_connection
      response = connection.post(@auth_url, @auth_data.to_json)
      auth = JSON.parse(response.body)
      self.token = auth['response']
    end

    def delete(url)
      connection.delete("#{@api_url}/#{url}")
    end

    def get(url)
      connection.get("#{@api_url}/#{url}")
    end

    def post(url, data = {}, body = '')
      connection.post do |req|
        req.url "#{@api_url}/#{url}"
        req.body  = body.to_s
      end
    end

    def put(url, data = {}, body = '')
      connection.put do |req|
        req.url "#{@api_url}/#{url}"
        req.body  = body.to_s
      end
    end

    private

    def token= token_string
      @token = token_string
      #Nacre::Token.new(token_string) #should use "try" #TODO add token verification
      connection.headers['brightpearl-auth'] = @token
    end

    def token
      @token
    end

    def reset_connection
      self.connection = Faraday.new
      connection.headers['Content-Type'] = 'application/json'
      connection.headers['Accept'] = 'json'
    end
  end
end
