#
# Chef Documentation
# https://docs.chef.io/libraries.html
#

#
# This module name was auto-generated from the cookbook name. This name is a
# single word that starts with a capital letter and then continues to use
# camel-casing throughout the remainder of the name.
#
module Qt
  module HelperHelpers

    def extract_user_sid_list
      pwsh_cmd = 'powershell -command "(Get-LocalUser | Select SID | ft -HideTableHeaders | Out-String).Trim()"'
      ran = Mixlib::ShellOut.new(pwsh_cmd).run_command
      ran.stdout.split("\r\n")
    end

    def get_current_user_sid
      cmd = 'whoami /logonid'
      ran = Mixlib::ShellOut.new(pwsh_cmd).run_command
      ran.stdout.rstrip
    end

    def get_current_username
      cmd = 'whoami'
      ran = Mixlib::ShellOut.new(cmd).run_command
      ran.stdout.rstrip
    end

    def is_local_system_user?
      get_current_username =~ /nt authority\\system/
    end
  end
end
