defmodule DocsWeb.PageLive.NavbarComponent do
  use DocsWeb, :live_component
  @impl true
  def render(assigns) do
    Phoenix.View.render(DocsWeb.PageView, "components/navbar_component.html", assigns)
  end

  @impl true
  def update(%{active_lang: active_lang, active_tab: active_tab}, socket) do
    {:ok, assign(socket, active_lang: active_lang, active_tab: active_tab)}
  end

end
