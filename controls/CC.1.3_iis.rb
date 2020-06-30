control "IIS Compliance Check 1.3" do
  impact 'critical'
  title "Check whether /tmp has the right user and group"
  desc  "Check whether /tmp has the right user and group"


  tag requirements: 'S - healthcheck and baseline'
  tag section: 'CH 1.3'


  describe directory('/tmp') do
    it { should exist }
    its('owner') { should be_in ['root','wluser'] }
    its('group') { should cmp 'root'}
  end
end
