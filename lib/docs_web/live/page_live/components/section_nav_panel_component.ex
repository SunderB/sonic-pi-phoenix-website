require IEx

defmodule DocsWeb.PageLive.SectionNavPanelComponent do
  use DocsWeb, :live_component

  @impl true
  def render(assigns) do
    Phoenix.View.render(DocsWeb.PageView, "components/section_nav_panel_component.html", assigns)
  end

  @impl true
  def update(%{mobile: mobile, active_lang: active_lang, active_page: active_page, active_tab: active_tab, active_pages: active_pages, section_nav_slideover: section_nav_slideover, page_keys: page_keys}, socket) do
    case active_tab do
      nil -> {:ok, assign(socket, mobile: mobile, active_lang: active_lang, active_pages: active_pages, section_nav_slideover: section_nav_slideover, page_keys: page_keys)}
      _ -> {:ok, assign(socket, mobile: mobile, active_lang: active_lang, active_tab: active_tab, active_page: active_page, section_nav_slideover: section_nav_slideover, page_keys: page_keys, active_pages: %{active_pages | active_tab => active_page},)}
    end
  end
end
