defmodule DocsWeb.PageLive.ContentComponent do
  use DocsWeb, :live_component

  @impl true
  def update(%{content: content, active_tab: active_tab, active_page: active_page}, socket) do
    {:ok, assign(socket, content: content, active_tab: active_tab, active_page: active_page)}
  end

  @impl true
  def render(assigns) when assigns.active_tab == :fx or assigns.active_tab == :synths do
    Phoenix.View.render(DocsWeb.PageView, "components/synths_or_fx_component.html", assigns)
  end

  def render(assigns) when assigns.active_tab == :samples do
    Phoenix.View.render(DocsWeb.PageView, "components/samples_component.html", assigns)
  end

  def render(assigns) when assigns.active_tab == :lang do
    Phoenix.View.render(DocsWeb.PageView, "components/lang_component.html", assigns)
  end

  def render(assigns) when assigns.active_tab == :tutorial do
    Phoenix.View.render(DocsWeb.PageView, "components/tutorial_component.html", assigns)
  end

  def render(assigns) when assigns.active_tab == :home do
    Phoenix.View.render(DocsWeb.PageView, "components/welcome_component.html", assigns)
  end
end
