module Fluent
  class XForwardedForFilter < Filter
    Plugin.register_filter('x_forwarded_for', self)

    RE_IP = /^(([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]).){3}([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/

    config_param :forwarded_for_key, :string, :default => 'x_forwarded_for'
    config_param :client_ip_key, :string, :default => 'client_ip'
    config_param :remote_addr_key, :string, :default => 'remote_addr'


    def filter(tag, time, record)
      if record[@forwarded_for_key] == '-'
        record.delete(@forwarded_for_key)
      end
      if record[@forwarded_for_key]
        record[@client_ip_key] = record[@forwarded_for_key].split(',')[-1].strip
      else
        record[@client_ip_key] = record[@remote_addr]
      end
      if not record[@client_ip_key].match(RE_IP)
        record[@client_ip_key] = record[@remote_addr]
      end
      # begin
      #   IPAddr.new(record['client_ip'])
      # rescue
      #   record[@client_ip_key] = '0.0.0.0'
      # end
      record
    end
  end
end
