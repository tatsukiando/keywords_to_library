#!/usr/bin/env ruby

require 'cgi'
require 'rexml/document'
require 'xml/xslt'
require 'net/http'
require 'uri'

cgi = CGI.new
isbn = cgi['isbn']
app_key = "app_key"

def fetch_api_data(app_key, isbn, session = nil)
  url = "http://api.calil.jp/check?appkey=#{app_key}&isbn=#{isbn}&format=xml&systemid=Univ_Tsukuba"
  url += "&session=#{session}" if session
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  raise "API request failed with status #{response.code}" unless response.is_a?(Net::HTTPSuccess)

  REXML::Document.new(response.body)
end

begin
    session = nil
    continue = 1
    api_doc = nil

    while continue == 1
      api_doc = fetch_api_data(app_key, isbn, session)
      continue = REXML::XPath.first(api_doc, "//continue").text.to_i
      session = REXML::XPath.first(api_doc, "//session").text if session.nil?
      sleep 5 if continue == 1 
    end

    xslt = XML::XSLT.new()
    xslt.xml = api_doc.to_s
    xslt.xsl = "lib_status.xsl"
    result = xslt.serve()
    
    print cgi.header("text/html; charset=UTF-8")
    print result
rescue => e
  print cgi.header("text/plain; charset=UTF-8")
  print "Error: #{e.message}\n"
  print e.backtrace.join("\n")
end
