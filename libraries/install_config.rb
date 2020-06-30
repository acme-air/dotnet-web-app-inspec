
class InstallConfig < Inspec.resource(1)

    name 'install_config'

    @install_root

    def initialize(install_root)
        @install_root = install_root
    end

    # Check whether all the files under the install_root has owner as either
    # wlmaster or wluser. To do this, We use a shell command

    def has_valid_owners_for_all_files?
        num_owned_by_wlmaster = num_files_owned_by_user('wlmaster')
        num_owned_by_wluser = num_files_owned_by_user('wluser')
        num_total = num_files_total
        # if all the files are owned by either 'wlmaster' or 'wluser', then
        # num_total must be equal to the sum of num_owned_by_wlmaster and num_owned_by_wluser.
        # If this condition is not matched, that means, there is at least one file
        # or directory, which is not owned by either of them.
        num_total == (num_owned_by_wlmaster + num_owned_by_wluser)
    end
    def has_access_to_others?
        num_directories = num_sub_directories_with_no_access_to_others
        # Test is success when the value is zero. Since this is expected to
        # return false, for test success, we negate the result.
        num_directories != 0
    end
    # Following are the private methods
    private
    # A method to find out the number of files owned by a given user.
    def num_files_owned_by_user(in_user_name)
        command_string = 'find '+@install_root+' -user '+in_user_name+' | wc -l'
        inspec.bash(command_string).stdout.split("\n")[0].strip.to_i
    end

    # A method to find out the number of files owned by a given user.
    def num_files_total
        command_string = 'find '+@install_root+' | wc -l'
        inspec.bash(command_string).stdout.split("\n")[0].strip.to_i
    end

    def num_sub_directories_with_no_access_to_others
        command_string = 'find '+@install_root+' -type d -perm -o=r | wc -l'
        inspec.bash(command_string).stdout.split("\n")[0].strip.to_i
    end
end
