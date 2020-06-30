# Some of the common utilities functions which will be used in
# other profile rules
class WeblogicUtils < Inspec.resource(1)

    name 'weblogic_utils'
    # Instance variable for domain_home. Eg: /tech/appl/test9/user_projects/poc-chef/
    @d_home
    # Instance variable for domain_user. Eg: test9
    @d_user
    # Instance variable for domain_name. Eg: poc_chef
    @d_name
    # Instance variable for base directory. Eg: /tech/appl/
    @d_base_dir

    def initialize(domain_home)
        @d_home = domain_home
        parts = domain_home.split('/')
        @d_user = parts[3]
        @d_name = parts[5]
        # Split the domain_home into two, based on the domain_user, and take the first one. Eg. /tech/appl/
        @d_base_dir = domain_home.split(@d_user)[0]
    end
    # A utility to find out the logged in user. Basically we run the
    # 'id' command under unix to find out the same.
    def logged_in_user
        inspec.command('id -u -n').stdout
    end

    def domain_user
        @d_user
    end

    def domain_name
        @d_name
    end
    def base_dir
        @d_base_dir
    end
    def daily_log_dir
        directory_name = @d_base_dir+@d_user+'/dailylog/'+@d_name
        inspec.file(directory_name)
    end
    def config_file
        config_file_name = @d_home+'/config/config.xml'
        inspec.file(config_file_name)
    end

end
