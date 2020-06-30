control "IIS Compliance Check 1.2" do
  impact 'critical'
  title "Check whether IIS server is running"
  desc  "Check whether IIS server is running on the system"


  tag requirements: 'S - healthcheck and baseline'
  tag section: 'CH 1.2'

  domain_home = attribute('IIS_HOME')

  # Check for the existence of service
  describe service('iptables') do
    it { should be_installed }
    it { should be_running }
  end
end