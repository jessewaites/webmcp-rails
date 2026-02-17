# webmcp-rails

![webmcp-rails](webmcp-rails.jpeg)

Rails helpers for [WebMCP](https://webmachinelearning.github.io/webmcp/), a W3C standard that lets websites expose HTML forms as structured tools for AI agents.

Adds a `webmcp:` option to `form_with`, `form_for`, and all form input helpers.

## Installation

```ruby
gem "webmcp-rails"
```

## Usage

```ruby
form_with model: @todo, webmcp: { tool: "addTodo", description: "Add a new todo item", autosubmit: true } do |f|
  f.text_field :title, webmcp: { param_description: "Title of the todo" }
  f.date_field :due_date, webmcp: { param_description: "Due date", param_title: "Due Date" }
  f.submit "Add"
end
```

Renders:

```html
<form toolname="addTodo" tooldescription="Add a new todo item" toolautosubmit action="/todos" method="post">
  <input type="text" name="todo[title]" toolparamdescription="Title of the todo" />
  <input type="date" name="todo[due_date]" toolparamdescription="Due date" toolparamtitle="Due Date" />
  <input type="submit" value="Add" />
</form>
```

### Form options

| Ruby key | HTML attribute | Description |
|----------|---------------|-------------|
| `tool:` | `toolname` | Tool name exposed to AI agents |
| `description:` | `tooldescription` | Human-readable tool description |
| `autosubmit:` | `toolautosubmit` | Allow agents to submit without confirmation |

### Field options

| Ruby key | HTML attribute | Description |
|----------|---------------|-------------|
| `param_description:` | `toolparamdescription` | Parameter description |
| `param_title:` | `toolparamtitle` | Display title for the parameter |

### Supported field helpers

`text_field`, `email_field`, `password_field`, `number_field`, `date_field`, `datetime_field`, `time_field`, `url_field`, `telephone_field`, `search_field`, `text_area`, `color_field`, `range_field`, `hidden_field`, `select`

## Requirements

- Ruby >= 3.1
- Rails >= 7.0

## License

MIT
