control "IIS Compliance Check 1.2" do
  impact 'critical'
  title "Check whether /tmp exists"
  desc  "Check whether /tmp exists"


  tag requirements: 'S - healthcheck and baseline'
  tag section: 'CH 1.2'

  describe directory('/tmp') do
    it { should exist }
  end
end
