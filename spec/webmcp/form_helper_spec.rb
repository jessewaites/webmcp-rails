# frozen_string_literal: true

require "spec_helper"

RSpec.describe Webmcp::FormHelper do
  let(:template) do
    view = ActionView::Base.new(ActionView::LookupContext.new([]), {}, nil)
    view.extend(ActionView::Helpers::FormHelper)
    view.extend(ActionView::Helpers::UrlHelper)
    view
  end

  describe "#form_with" do
    it "renders toolname and tooldescription attributes" do
      html = template.form_with(url: "/todos", webmcp: { tool: "addTodo", description: "Add a todo" }) do |f|
        ""
      end

      expect(html).to include('toolname="addTodo"')
      expect(html).to include('tooldescription="Add a todo"')
    end

    it "renders toolautosubmit as bare attribute" do
      html = template.form_with(url: "/todos", webmcp: { tool: "addTodo", autosubmit: true }) do |f|
        ""
      end

      expect(html).to include("toolautosubmit")
      expect(html).not_to include('toolautosubmit="true"')
    end

    it "sets builder to Webmcp::FormBuilder when webmcp present" do
      builder_class = nil
      template.form_with(url: "/todos", webmcp: { tool: "addTodo" }) do |f|
        builder_class = f.class
        ""
      end

      expect(builder_class).to eq(Webmcp::FormBuilder)
    end

    it "does not affect forms without webmcp option" do
      html = template.form_with(url: "/todos") do |f|
        ""
      end

      expect(html).not_to include("toolname")
      expect(html).not_to include("tooldescription")
      expect(html).not_to include("toolautosubmit")
    end

    it "preserves existing html options" do
      html = template.form_with(url: "/todos", html: { id: "my-form" }, webmcp: { tool: "addTodo" }) do |f|
        ""
      end

      expect(html).to include('id="my-form"')
      expect(html).to include('toolname="addTodo"')
    end
  end
end
