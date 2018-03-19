Puppet::Functions.create_function(:'puppetstats::track') do
  dispatch :track do
    param 'String', :fqmn
    param 'String', :module_name
  end

  def track(fqmn, module_name)
    require 'net/http'
    require 'uri'
    require 'json'

    uri = URI.parse('https://puppetstats.com')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new("/api/modules/#{fqmn}")

    scope = closure_scope

    unique_identifier = Digest::MD5.new
    unique_identifier.update scope['facts']['networking']['fqdn']

    version = nil
    metadata = nil

    begin
      metadata = call_function('load_module_metadata', module_name, true)
    rescue
      Puppet.send('warning', "Could not detect version for module '#{module_name}'. Make sure your puppet environment is set up correctly. puppetstats cannot analyse data without a version.")
    else
      version = metadata['version']
      if version.to_s.empty?
        Puppet.send('fail', "The module '#{module_name}' has no metadata.json. puppetstats cannot analyse data without a version in that files.")
      end
    end

    data = {
        :system => unique_identifier,
        :time => Time.now.to_i,
        :version => version,
        :data => {
            :facterversion => scope['facts']['facterversion'],
            :is_virtual => scope['facts']['is_virtual'],
            :kernel => scope['facts']['kernel'],
            :kernelmajversion => scope['facts']['kernelmajversion'],
            :kernelrelease => scope['facts']['kernelrelease'],
            :kernelversion => scope['facts']['kernelversion'],
            :os => scope['facts']['os'],
            :ruby => scope['facts']['ruby'],
            :timezone => scope['facts']['timezone'],
            :puppetversion => scope['facts']['puppetversion'],
        }
    }

    request.body = data.to_json

    response = http.request(request)

    Puppet.send('debug', "puppetstats HTTP request body:\n#{request.body}")
    Puppet.send('debug', "puppetstats HTTP response code:\n#{response.code}")
    Puppet.send('debug', "puppetstats HTTP response body:\n#{response.body}")

    case response.code.to_i
      when 200
        Puppet.send('notice', "puppetstats anonymously tracked module '#{fqmn}' on system '#{unique_identifier}'")
      else
        Puppet.send('warning', "puppetstats anonymous tracking failed for module #{fqmn} with status code '#{response.code}':\n#{response.body}")
    end
  end
end