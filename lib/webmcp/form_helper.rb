# frozen_string_literal: true

module Webmcp
  module FormHelper
    def form_with(**options, &block)
      options = inject_webmcp_form_attrs(options)
      super(**options, &block)
    end

    def form_for(record, options = {}, &block)
      options = inject_webmcp_form_attrs(options)
      super(record, options, &block)
    end

    private

    def inject_webmcp_form_attrs(options)
      webmcp = options.delete(:webmcp)
      return options unless webmcp

      html_attrs = {}
      html_attrs[:toolname] = webmcp[:tool] if webmcp[:tool]
      html_attrs[:tooldescription] = webmcp[:description] if webmcp[:description]
      html_attrs[:toolautosubmit] = "toolautosubmit" if webmcp[:autosubmit]

      options[:html] = (options[:html] || {}).merge(html_attrs)
      options[:builder] = Webmcp::FormBuilder unless options.key?(:builder)
      options
    end
  end
end
