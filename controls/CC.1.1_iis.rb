control "IIS Compliance Check 1.1 " do
  impact 'critical'
  title "Check the mode of /etc/hosts file"
  desc  "Check the mode of /etc/hosts file"


  tag requirements: 'S - healthcheck and baseline'
  tag section: 'CH 1.1'

  describe file('/etc/hosts') do
    it { should exist }
    its('mode') { should cmp '0644' }
  end

end
