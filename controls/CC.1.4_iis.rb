control "IIS Compliance Check 1.4" do
  impact 'critical'
  title "Check whether SSH is running"
  desc  "Check whether SSH is running on the system"


  tag requirements: 'S - healthcheck and baseline'
  tag section: 'CH 1.4'

  describe service('ssh') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
