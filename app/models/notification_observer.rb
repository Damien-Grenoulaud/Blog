class NotificationObserver < ActiveRecord::Observer
    observe :article
    def after_save(record)
      puts("test")
      #UserMailer.with(user: Current.user).welcome_email.deliver_now
    end
  end