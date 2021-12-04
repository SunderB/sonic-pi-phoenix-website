require IEx

defmodule DocsWeb.PageLive do
  use DocsWeb, :live_view

  @impl true
  def mount(_params, %{"metadata" => metadata}, socket) do
    IO.puts "Processing:"
    #IO.puts inspect(metadata)

    # Filter out TOML files located in _build
    metadata = Enum.reject(metadata, fn {k, _v} -> k == :_build end)

    # Set default language, tab, and page
    active_lang = :en
    active_tab = :synths
    active_page = :dull_bell

    #IO.puts inspect(metadata)

    page_keys = Enum.into(metadata[active_lang], %{}, fn {k, v} -> {k, Enum.flat_map(v, fn x -> Map.keys(x) end)} end)
    active_pages = Enum.into(metadata[active_lang], %{}, fn {k, v} -> {k, hd(Enum.flat_map(v, fn x -> Map.keys(x) end))} end)
    content = Enum.find(metadata[active_lang][active_tab], fn p -> Enum.member?(Map.keys(p), active_page)  end)
    %{^active_page => data} = content
    {:ok, assign(socket, metadata: metadata, active_lang: active_lang, active_tab: active_tab, active_page: active_page, active_pages: active_pages, page_keys: page_keys[active_tab], content: data)}
  end

  @impl true
  def render(assigns) do
    if (assigns.active_tab == :home and assigns.active_page == :welcome) do
      Phoenix.View.render(DocsWeb.PageView, "welcome_page.html", assigns)
    else
      Phoenix.View.render(DocsWeb.PageView, "doc_page.html", assigns)
    end

  end

  # def error_404(socket) do
  #   active_page = String.to_atom("error_404")
  #   content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
  #   %{^active_page => data} = content
  #   {:noreply, assign(socket, active_lang: active_lang, active_pages: %{socket.assigns.active_pages | active_tab => active_page}, content: data)}
  # end

  @impl true
  def handle_event("change_tab", %{"active_tab" => active_tab}, socket) do
    active_lang = socket.assigns.active_lang
    active_tab = String.to_atom(active_tab)
    page_keys = Enum.into(socket.assigns.metadata[active_lang], %{}, fn {k, v} -> {k, Enum.flat_map(v, fn x -> Map.keys(x) end)} end)[active_tab]
    active_page = socket.assigns.active_pages[active_tab]
    pages = socket.assigns.metadata[active_lang][active_tab]
    content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
    %{^active_page => data} = content
    {:noreply, assign(socket, active_lang: active_lang, active_tab: active_tab, active_pages: socket.assigns.active_pages, page_keys: page_keys, content: data)}
  end

  @impl true
  def handle_event("change_page", %{"active_page" => active_page}, socket) do
    active_lang = socket.assigns.active_lang
    active_tab = socket.assigns.active_tab
    pages = socket.assigns.metadata[active_lang][active_tab]
    active_page = String.to_atom(active_page)
    content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
    %{^active_page => data} = content
    {:noreply, assign(socket, active_lang: active_lang, active_pages: %{socket.assigns.active_pages | active_tab => active_page}, content: data)}
  end

  @impl true
  def handle_params(%{"active_lang" => active_lang, "active_tab" => active_tab, "active_page" => active_page}=_params, _uri, socket) do
    active_lang = String.to_atom(active_lang)
    active_tab = String.to_atom(active_tab)
    pages = socket.assigns.metadata[active_lang][active_tab]
    page_keys = Enum.into(socket.assigns.metadata[active_lang], %{}, fn {k, v} -> {k, Enum.flat_map(v, fn x -> Map.keys(x) end)} end)[active_tab]
    active_page = String.to_atom(active_page)
    content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
    %{^active_page => data} = content
    #IO.puts inspect({:noreply, assign(socket, active_tab: active_tab, active_pages: %{socket.assigns.active_pages | active_tab => active_page}, page_keys: page_keys, content: data)})
    {:noreply, assign(socket, active_lang: active_lang, active_tab: active_tab, active_pages: %{socket.assigns.active_pages | active_tab => active_page}, page_keys: page_keys, content: data)}
  end


  def handle_params(%{"active_lang" => active_lang, "active_tab" => active_tab}=_params, _uri, socket) do
    active_lang = String.to_atom(active_lang)
    active_tab = String.to_atom(active_tab)
    try do
      page_keys = Enum.into(socket.assigns.metadata[active_lang], %{}, fn {k, v} -> {k, Enum.flat_map(v, fn x -> Map.keys(x) end)} end)[active_tab]
      active_page = socket.assigns.active_pages[active_tab]
      pages = socket.assigns.metadata[active_lang][active_tab]
      content = Enum.find(pages, fn p -> Enum.member?(Map.keys(p), active_page)  end)
      %{^active_page => data} = content
      {:noreply, assign(socket, active_lang: active_lang, active_tab: active_tab, active_pages: socket.assigns.active_pages, page_keys: page_keys, content: data)}
    rescue
      Protocol.UndefinedError ->
        raise DocsWeb.PageNotFoundError, "Error 404: Page not found"
    end
  end

  @impl true
  def handle_params(params, uri, socket) do
    #IO.puts uri
    #IO.inspect(IEx.Info.info(params))
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

end
