class ConfirmationMailer < ApplicationMailer
  def confirm_email(target_email, activation_token)
    @activation_token = activation_token
    mail(:to => target_email,
         :from => "dumbstawn@gmail.com",
    :subject => "[Task 5]") do |format|
      format.html { render 'confirm_email'}
    end
  end

end
