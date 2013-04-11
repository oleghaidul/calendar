class PaymentNotificationsController < ApplicationController
  include ActiveMerchant::Billing::Integrations
  protect_from_forgery except: [:create, :paypal_return, :paypal_cancel]
  before_filter :load_notify, only: [:create, :paypal_return]

  def paypal_return
    flash[:notice] = "Waiting for your balance to update after a payment"
    redirect_to edit_calendar_url(@calendar)
  end

  def paypal_cancel
    flash[:notice] = "Cancel payment"
    redirect_to calendars_url
  end

  def create
    if @notify.acknowledge
      if @notify.complete?
        PaymentNotification.create!(params: params, user_calendar: @calendar, status: params[:payment_status], transaction_id: params[:txn_id] )
      end
    end
    render nothing: true
  end

  private

    def load_notify
      @notify = Paypal::Notification.new request.raw_post
      @calendar = UserCalendar.find(@notify.item_id)
    end
end