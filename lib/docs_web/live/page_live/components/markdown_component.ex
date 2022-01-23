require Earmark

defmodule DocsWeb.PageLive.MarkdownComponent do
  use DocsWeb, :live_component

  def render_md(content) do
    # Make links open in a new tab
    add_target = fn node -> Earmark.AstTools.merge_atts_in_node(node, target: "_blank") end
    options = [
      registered_processors: [
        {"a", add_target}
      ]
    ]

    {status, html, error} = Earmark.as_html(content, options)

    if status == :error do
      [{err_type, line_no, message}] = error
      if err_type == :warning do
        IO.puts(:stderr, "Warning when processing at line #{line_no}: #{message}")
      else
        IO.puts(:stderr, "Error when processing at line #{line_no}: #{message}")
      end
    end

    html
  end

  @impl true
  def render(assigns) do
    assigns = assign(assigns, :html, render_md(assigns.content))
    Phoenix.View.render(DocsWeb.PageView, "components/markdown_component.html", assigns)
  end

  @impl
  def update(%{content: content}, socket) do
    {:ok, assign(socket, content: content)}
  end
end
