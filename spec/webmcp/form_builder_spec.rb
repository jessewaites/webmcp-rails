# frozen_string_literal: true

require "spec_helper"

RSpec.describe Webmcp::FormBuilder do
  let(:template) do
    view = ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
    view.extend(ActionView::Helpers::FormHelper)
    view.extend(ActionView::Helpers::UrlHelper)
    view
  end

  let(:builder) do
    Webmcp::FormBuilder.new(:todo, nil, template, {})
  end

  describe "input helpers with webmcp" do
    it "renders toolparamdescription on text_field" do
      html = builder.text_field(:title, webmcp: { param_description: "Title of the todo" })
      expect(html).to include('toolparamdescription="Title of the todo"')
    end

    it "renders toolparamtitle on text_field" do
      html = builder.text_field(:title, webmcp: { param_title: "Todo Title" })
      expect(html).to include('toolparamtitle="Todo Title"')
    end

    it "renders both toolparamdescription and toolparamtitle" do
      html = builder.date_field(:due_date, webmcp: { param_description: "Due date", param_title: "Due Date" })
      expect(html).to include('toolparamdescription="Due date"')
      expect(html).to include('toolparamtitle="Due Date"')
    end

    it "does not affect fields without webmcp option" do
      html = builder.text_field(:title)
      expect(html).not_to include("toolparamdescription")
      expect(html).not_to include("toolparamtitle")
    end
  end

  describe "all supported field methods" do
    %i[text_field email_field password_field number_field
       date_field datetime_field time_field url_field
       telephone_field search_field text_area color_field range_field
       hidden_field].each do |method_name|
      it "supports webmcp on #{method_name}" do
        html = builder.public_send(method_name, :field, webmcp: { param_description: "desc" })
        expect(html).to include('toolparamdescription="desc"')
      end
    end
  end

  describe "#select" do
    it "renders toolparamdescription on select" do
      html = builder.select(:status, %w[active done], {}, webmcp: { param_description: "Status" })
      expect(html).to include('toolparamdescription="Status"')
    end
  end
end
