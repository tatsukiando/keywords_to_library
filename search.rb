#!/usr/bin/env ruby
# encoding: utf-8
require 'cgi'
require 'rexml/document'
require 'xml/xslt'

cgi = CGI.new

print cgi.header("text/html; charset=utf-8")

begin
  xslt = XML::XSLT.new()
  xslt.xml = "data0422.xml"
  xslt.xsl = "keywords.xsl"

  result = xslt.serve()

  print result
rescue => e
  puts "Content-Type: text/html\n\n"
  puts "<html><body>"
  puts "<h1>Internal Server Error</h1>"
  puts "<p>#{e.message}</p>"
  puts "<pre>#{e.backtrace.join("\n")}</pre>"
  puts "</body></html>"
end
