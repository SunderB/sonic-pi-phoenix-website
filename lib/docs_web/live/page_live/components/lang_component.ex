defmodule DocsWeb.PageLive.LangComponent do
  use DocsWeb, :live_component

  @impl true
  def update(%{active_page: active_page, content: content}, socket) do
    {:ok, assign(socket, active_page: active_page, content: content)}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(DocsWeb.PageView, "components/lang_component.html", assigns)
  end
end
