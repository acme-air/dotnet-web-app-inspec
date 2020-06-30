control "IIS Compliance Check 1.1 " do
  impact 'critical'
  title "Check the existence of default application"
  desc  "Check whether the default application exists in IIS server"


  tag requirements: 'S - healthcheck and baseline'
  tag section: 'CH 1.1'

  domain_home = attribute('IIS_HOME')

  # Check for the existence of the daily log file, and its permissions
  describe directory('/tmp1') do
    it { should exist }
  end

end
