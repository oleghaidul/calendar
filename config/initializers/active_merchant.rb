require 'active_merchant/billing/integrations/action_view_helper'
ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

PAYPAL_ACCOUNT = AppConfig.paypal['login']
PAYPAL_PRICE = AppConfig.paypal['price']

ActiveMerchant::Billing::Base.mode = AppConfig.paypal['mode'] || :test