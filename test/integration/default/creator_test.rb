# # encoding: utf-8

# Inspec test for recipe qt::creator

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

return unless os.windows?

describe registry_key({
  hive: 'HKEY_CURRENT_USER'
  }).children(/\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall/).each  { |key| 
   if registry_key(key)['Comments'] =~ /Qt Creator/
     describe registry_key(key) do
       its('DisplayName') { should match(/Qt Creator/) }
     end
   end
 }
