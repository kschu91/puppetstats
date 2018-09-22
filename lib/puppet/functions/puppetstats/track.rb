Puppet::Functions.create_function(:'puppetstats::track') do
  dispatch :track do
    param 'String', :fqmn
    param 'String', :module_name
  end

  def track(fqmn, module_name)
    require 'net/http'
    require 'uri'
    require 'json'

    Puppet.send('notice', "puppetstats is active for module '#{fqmn}'. To disable puppetstats on your server/node, visit https://puppetstats.com/opt-out")

    version = nil
    metadata = nil

    begin
      metadata = call_function('load_module_metadata', module_name, false)
    rescue => error
      Puppet.send('warning', "Could not detect version for module '#{fqmn}' using '#{module_name}': #{error}")
    else
      begin
        version = metadata['version']
        if version.to_s.empty?
          Puppet.send('warning', "The module '#{module_name}' has no metadata.json. puppetstats cannot analyse data without a module version.")
        else
          uri = URI.parse('https://puppetstats.com')
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true

          request = Net::HTTP::Post.new("/api/modules/#{fqmn}")

          scope = closure_scope
          facts = scope['facts']

          unique_identifier = Digest::MD5.new
          if scope.to_hash.key?('server_facts')
            unique_identifier.update scope['server_facts']['servername'] + facts['networking']['fqdn']
            serverless = false
          else
            unique_identifier.update facts['networking']['fqdn']
            serverless = true
          end

          data = {
              :system => unique_identifier,
              :time => Time.now.to_i,
              :version => version,
              :data => {
                  :serverless => serverless,
                  :facterversion => facts['facterversion'],
                  :is_virtual => facts['is_virtual'],
                  :kernel => facts['kernel'],
                  :kernelmajversion => facts['kernelmajversion'],
                  :kernelrelease => facts['kernelrelease'],
                  :kernelversion => facts['kernelversion'],
                  :os => facts['os'],
                  :ruby => facts['ruby'],
                  :timezone => facts['timezone'],
                  :puppetversion => facts['puppetversion'],
              }
          }

          request.body = data.to_json

          response = http.request(request)

          Puppet.send('debug', "puppetstats HTTP request body:\n#{request.body}")
          Puppet.send('debug', "puppetstats HTTP response code:\n#{response.code}")
          Puppet.send('debug', "puppetstats HTTP response body:\n#{response.body}")

          case response.code.to_i
            when 200
              Puppet.send('notice', "puppetstats anonymously tracked usage of module '#{fqmn}' on system '#{unique_identifier}'.")
            when 503
              Puppet.send('notice', "Seems like puppetstats.com is doing some maintainence. Skipping anonymous usage tracking of module '#{fqmn}' for this run.")
            else
              Puppet.send('warning', "puppetstats anonymous usage tracking failed for module #{fqmn} with status code '#{response.code}':\n#{response.body}.")
          end
        end
      rescue => error
        Puppet.send('warning', "Could not track module '#{fqmn}' because of unknown error: #{error}")
      end
    end
  end
end