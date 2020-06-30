
class WeblogicConfig < Inspec.resource(1)

    name 'weblogic_config'

    @wl_util

    def initialize(domain_home)
        @wl_util = inspec.weblogic_utils(domain_home)
    end
    # return the daily log directory for the given domain, as an Inspec.File object.
    # This is more of a wrapper method to the same method in WeblogicUtils.
    def daily_log_dir
        @wl_util.daily_log_dir
    end

    def daily_log_dir_permissions
        @wl_util.daily_log_dir.mode
    end

    def config_file
        @wl_util.config_file
    end
    def authenticator
        resource = inspec.xml(@wl_util.config_file.path)
        list = resource.send("//sec:authentication-provider/sec:name")
        list.each do |one_entry|
            if one_entry.start_with?("WLADMIN_AD1Authenticator")
                return "configured"
            else
                return "not configured"
            end
        end
        "not configured"
    end

    def complete_message_timeout
        resource = inspec.xml(@wl_util.config_file.path)
        list = resource.send("//complete-message-timeout")
        # It is ok, if we do not find any match for this element. In that case
        # it will default to 60. So, let us set the initial value of timeout to 60
        timeout_value = 60
        list.each do |one_entry|
            if one_entry.eql?("60")
                return 60
            else
                return one_entry.to_s
            end
        end
        # If not match is found, it will come here and return the default.
        timeout_value
    end

    def production_mode_enabled
        resource = inspec.xml(@wl_util.config_file.path)
        list = resource.send("//production-mode-enabled")
        # iterate through the array and check for each entry, and see whether the value matches "true"
        # We expect only one entry in the 'list' array.
        entry_valid = false
        list.each do |one_entry|
            entry_valid = one_entry.eql?('true')
            if entry_valid
                # we return 'true'
                return true
            end
        end
        # The default is false. If the method has not returned from the above loop,
        # we return false.
        return entry_valid
    end

    def allow_unencrypted_null_cipher
        resource = inspec.xml(@wl_util.config_file.path)
        list = resource.send("//allow-unencrypted-null-cipher")
        # It is ok, if we do not find any match for this element. In that case
        # it will default to false. So, let us set the initial value to false
        enabled = false
        list.each do |one_entry|
            if one_entry.eql?("false")
                return false
            else
                return true
            end
        end
        # If not match is found, it will come here and return the default.
        enabled
    end
end
