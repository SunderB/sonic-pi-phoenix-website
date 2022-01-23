require IEx

defmodule DocsWeb.PageLive do
  use DocsWeb, :live_view

  alias DocsWeb.Utils, as: Utils

  defp get_content(metadata, lang, tab, page) do
    Enum.find(metadata[lang][tab], fn p -> Enum.member?(Map.keys(p), page)  end)
  end

  defp get_title(pair) do
    kw_list = Keyword.new(pair)
    key = hd(Keyword.keys(kw_list))
    data = kw_list[key]

    title = if (Map.has_key?(data, :title)) do data[:title] else key end
    {key, title}
  end

  defp page_keys(metadata, lang) do
    Enum.into(metadata[lang], %{},
      fn {sec_name, sec_val} -> {
        sec_name,
        Enum.map(sec_val, fn pair -> get_title(pair) end)
      } end
    )
  end

  defp page_keys(metadata, lang, tab) do
    page_keys(metadata, lang)[tab]
  end

  @impl true
  def mount(params, %{"metadata" => metadata_}, socket) do

    # Filter out TOML files located in _build
    metadata = Enum.reject(metadata_, fn {k, _v} -> (k == :_build or k == "_build") end)

    # Set default language, tab, and page
    active_lang = if (Map.has_key?(params, "active_lang")) do String.to_atom(params["active_lang"]) else :en end
    active_tab = if (Map.has_key?(params, "active_tab")) do String.to_atom(params["active_tab"]) else :synths end

    IO.puts inspect(metadata[active_lang])
    IO.puts "#{active_lang}/#{active_tab}"

    active_pages = Enum.into(metadata[active_lang], %{}, fn {k, v} -> {k, Utils.ListUtils.first_or_nil(Enum.flat_map(v, fn x -> Map.keys(x) end))} end)
    active_page = if (Map.has_key?(params, :active_page)) do params[:active_page] else active_pages[active_tab] end

    content = Enum.find(metadata[active_lang][active_tab], fn p -> Enum.member?(Map.keys(p), active_page)  end)
    %{^active_page => data} = content
    {
      :ok,
      assign(socket,
        metadata:     metadata,
        active_lang:  active_lang,
        active_tab:   active_tab,
        active_page:  active_page,
        active_pages: active_pages,
        page_keys:    page_keys(metadata, active_lang, active_tab),
        content:      data
      )
    }
  end

  @impl true
  def render(assigns) do
    if (assigns.active_tab == :home and assigns.active_page == :welcome) do
      Phoenix.View.render(DocsWeb.PageView, "welcome_page.html", assigns)
    else
      Phoenix.View.render(DocsWeb.PageView, "doc_page.html", assigns)
    end

  end

  @impl true
  def handle_event("change_tab", %{"active_tab" => active_tab}, socket) do
    active_lang = socket.assigns.active_lang
    active_tab = String.to_atom(active_tab)
    active_page = socket.assigns.active_pages[active_tab]
    pages = socket.assigns.metadata[active_lang][active_tab]
    content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
    %{^active_page => data} = content
    {
      :noreply,
      assign(socket,
        active_lang:  active_lang,
        active_tab:   active_tab,
        active_pages: socket.assigns.active_pages,
        page_keys:    page_keys(socket.assigns.metadata, active_lang, active_tab),
        content:      data
      )
    }
  end

  @impl true
  def handle_event("change_page", %{"active_page" => active_page}, socket) do
    active_lang = socket.assigns.active_lang
    active_tab = socket.assigns.active_tab
    pages = socket.assigns.metadata[active_lang][active_tab]
    active_page = String.to_atom(active_page)
    content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
    %{^active_page => data} = content
    {
      :noreply,
      assign(socket,
        active_lang:  active_lang,
        active_pages: %{socket.assigns.active_pages | active_tab => active_page},
        content:      data
      )
    }
  end

  @impl true
  def handle_params(%{"active_lang" => active_lang, "active_tab" => active_tab, "active_page" => active_page}=_params, _uri, socket) do
    active_lang = String.to_atom(active_lang)
    active_tab = String.to_atom(active_tab)
    pages = socket.assigns.metadata[active_lang][active_tab]
    active_page = String.to_atom(active_page)
    content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
    %{^active_page => data} = content
    {
      :noreply,
      assign(socket,
        active_lang: active_lang,
        active_tab: active_tab,
        active_pages: %{socket.assigns.active_pages | active_tab => active_page},
        page_keys: page_keys(socket.assigns.metadata, active_lang, active_tab),
        content: data
      )
    }
  end

  @impl true
  def handle_params(%{"active_lang" => active_lang, "active_tab" => active_tab}=_params, _uri, socket) do
    active_lang = String.to_atom(active_lang)
    active_tab = String.to_atom(active_tab)
    try do
      active_page = socket.assigns.active_pages[active_tab]
      pages = socket.assigns.metadata[active_lang][active_tab]
      content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
      %{^active_page => data} = content
      {
        :noreply,
        assign(socket,
          active_lang: active_lang,
          active_tab: active_tab,
          active_pages: socket.assigns.active_pages,
          page_keys: page_keys(socket.assigns.metadata, active_lang, active_tab),
          content: data
        )
      }
    rescue
      Protocol.UndefinedError ->
        raise DocsWeb.PageNotFoundError, "Error 404: Page not found"
    end
  end

  @impl true
  def handle_params(params, _uri, socket) do
    if(map_size(params) == 0) do
      # Show welcome page
      {:noreply, assign(socket, active_tab: :home, active_page: :welcome, content: nil)}
    else
      raise DocsWeb.PageNotFoundError, "Error 404: Page not found"
    end

    # active_tab = String.to_atom("home")
    # pages = socket.assigns.metadata[active_tab]
    # page_keys = Enum.into(socket.assigns.metadata, %{}, fn {k, v} -> {k, Enum.flat_map(v, fn x -> Map.keys(x) end)} end)[active_tab]
    # active_page = String.to_atom(active_page)
    # content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
    # %{^active_page => data} = content
    # IO.puts inspect({:noreply, assign(socket, active_tab: active_tab, active_pages: %{socket.assigns.active_pages | active_tab => active_page}, page_keys: page_keys, content: data)})
    # {:noreply, assign(socket, active_tab: active_tab, active_pages: %{socket.assigns.active_pages | active_tab => active_page}, page_keys: page_keys, content: data)}
  end

  # def error_404(socket) do
  #   active_page = String.to_atom("error_404")
  #   content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
  #   %{^active_page => data} = content
  #   {:noreply, assign(socket, active_lang: active_lang, active_pages: %{socket.assigns.active_pages | active_tab => active_page}, content: data)}
  # end

end
