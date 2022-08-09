defmodule DocsWeb.PageLive.LangSwitcherComponent do
  use DocsWeb, :live_component

  @impl true
  def update(%{active_lang: active_lang, active_tab: active_tab, active_page: active_page}, socket) do
    {:ok, assign(socket, active_lang: active_lang, active_tab: active_tab, active_page: active_page)}
  end

  @impl true
  def render(assigns) do
    Phoenix.View.render(DocsWeb.PageView, "components/lang_switcher_component.html", assigns)
  end
end
