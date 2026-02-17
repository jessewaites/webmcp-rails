# frozen_string_literal: true

module Webmcp
  class Railtie < Rails::Railtie
    initializer "webmcp.form_helpers" do
      ActiveSupport.on_load(:action_view) do
        ActionView::Helpers::FormHelper.prepend(Webmcp::FormHelper)
      end
    end
  end
end
