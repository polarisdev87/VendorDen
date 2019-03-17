class TestMailer < ApplicationMailer

  def test_mail
    @datetime = Time.zone.now.strftime('%Y-%m-%d %H:%M:%S')
    mail(to: 'neil.r.zamora@gmail.com', subject: "Test Message from LaunchPeer #{@datetime}")
  end
end
