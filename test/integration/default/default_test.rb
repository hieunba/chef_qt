# # encoding: utf-8

# Inspec test for recipe qt::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

return unless os.windows?

describe file('C:\Qt\Qt5\MaintenanceTool.exe') do
  it { should exist }
end

describe registry_key({
  hive: 'HKEY_CURRENT_USER'
  }).children(/\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall/).each  { |key| 
   if registry_key(key)['Comments'] =~ /Qt [0-9]/
     describe registry_key(key) do
       its('DisplayName') { should match(/Qt [0-9]+?.[0-9]+?.[0-9]+?/) }
     end
   end
 }
