class InvitationMailer < ApplicationMailer
  def invitation(invitation)
    @invitation = invitation

    @accept_url = accept_invitation_url(token: @invitation.token)

    mail(
      to: @invitation.email,
      from: Rails.application.credentials.dig(:gmail, :username).presence || "from@example.com",
      subject: t(".subject")
    )
  end
end
