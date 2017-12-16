class UserNotificationMailer < ApplicationMailer

  def new_possible_pirate_product_found(product)
    @product = product

    mail(from: ENV['CONTACT_EMAIL_FROM'], to: ENV['CONTACT_EMAIL_SUPPORT'], subject: 'New Product Found')
  end
end
