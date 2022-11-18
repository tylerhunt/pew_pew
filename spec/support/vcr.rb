require 'cgi'
require 'vcr'

VCR.configure do |config|
  config.hook_into :faraday

  config.cassette_library_dir = File.expand_path('../../fixtures', __FILE__)

  config.register_request_matcher :multipart_body do |request_1, request_2|
    pattern = /RubyMultipartPost-\w+$/

    content_type_1 = request_1.headers['Content-Type']
    content_type_2 = request_2.headers['Content-Type']

    if content_type_1 && content_type_2 && content_type_1[0] =~ pattern
      boundary_1 = $~[0]
      boundary_2 = content_type_2[0].match(pattern)[0]

      request_1.body.gsub(boundary_1, boundary_2) == request_2.body
    else
      CGI.parse(request_1.body) == CGI.parse(request_2.body)
    end
  end

  config.register_request_matcher :multipart_headers do |request_1, request_2|
    except = []

    content_type_1 = request_1.headers['Content-Type']
    content_type_2 = request_2.headers['Content-Type']

    if content_type_1 && content_type_1[0] =~ /RubyMultipartPost/ &&
      content_type_2 && content_type_2[0] =~ /RubyMultipartPost/ &&
      except << 'Content-Type'
    end

    request_1.headers.except(*except) == request_2.headers.except(*except)
  end
end
