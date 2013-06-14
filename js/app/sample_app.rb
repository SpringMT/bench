# encoding: UTF-8
require 'rack/request'
require 'rack/response'
require 'ap'

class SampleApp
  def call(env)
    req = Rack::Request.new(env)
    ap req.body.read
    ap req.query_string
    ap req.request_method
    case req.request_method
    when 'OPTIONS'
      response = Rack::Response.new do |r|
        r.status = 200
        r["Access-Control-Allow-Origin"] = "*"
        r["Access-Control-Allow-Headers"] = "X-Requested-With"
      end
    when 'GET'
      response = Rack::Response.new do |r|
        r.status = 200
        r["Content-Type"] = "text/html"
        r["Access-Control-Allow-Origin"] = "*"
        r["Access-Control-Allow-Headers"] = "X-Requested-With"
        #r.write %Q!<html><body><img src="http://localhost:3001#{req.path_info}"></body></html>!
        r.write \
          "<html><body> \
            request_method : #{req.request_method}<br> \
            path_info      : #{req.path_info}<br> \
            query_string   : #{req.query_string}<br> \
            scheme         : #{req.scheme}<br> \
            url            : #{req.url}<br> \
            script_name    : #{req.script_name}<br> \
          </body></html>"
      end
    when 'POST'
      ap req.body
      ap req.query_string
      response = Rack::Response.new do |r|
        r.status = 200
        r["Content-Type"] = "text/html"
        r["Access-Control-Allow-Origin"] = "*"
        r["Access-Control-Allow-Headers"] = "X-Requested-With"
        #r.write %Q!<html><body><img src="http://localhost:3001#{req.path_info}"></body></html>!
        r.write \
          "<html><body> \
            request_method : #{req.request_method}<br> \
            path_info      : #{req.path_info}<br> \
            query_string   : #{req.query_string}<br> \
            scheme         : #{req.scheme}<br> \
            url            : #{req.url}<br> \
            script_name    : #{req.script_name}<br> \
          </body></html>"
      end

    end
  end
end




