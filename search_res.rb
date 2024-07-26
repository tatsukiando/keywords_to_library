#!/usr/bin/env ruby

require 'cgi'
require 'rexml/document'
require 'xml/xslt'

cgi = CGI.new
keyword = cgi['keyword']

begin
  xslt = XML::XSLT.new()
  xslt.xml = "data0422.xml"
  xslt.xsl = "search_res.xsl"
  xslt.parameters = { "keyword" => keyword }
  result = xslt.serve()
    
  print cgi.header("text/html; charset=UTF-8")
  print result
rescue => e
  print cgi.header("text/plain; charset=UTF-8")
  print "Error: #{e.message}\n"
  print e.backtrace.join("\n")
end
