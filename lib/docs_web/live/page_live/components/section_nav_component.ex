require IEx

defmodule DocsWeb.PageLive.SectionNavComponent do
  use DocsWeb, :live_component

  @impl true
  def render(assigns) do
    Phoenix.View.render(DocsWeb.PageView, "components/section_nav_component.html", assigns)
  end

  @impl true
  def update(%{active_lang: active_lang, active_page: active_page, active_tab: active_tab, active_pages: active_pages, page_keys: page_keys}, socket) do
    case active_tab do
      nil -> {:ok, assign(socket, active_lang: active_lang, active_pages: active_pages, page_keys: page_keys)}
      _ -> {:ok, assign(socket, active_lang: active_lang, active_tab: active_tab, active_page: active_page, active_pages: %{active_pages | active_tab => active_page}, page_keys: page_keys)}
    end
  end
end
