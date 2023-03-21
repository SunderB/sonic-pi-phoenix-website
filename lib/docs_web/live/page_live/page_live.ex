require IEx

defmodule DocsWeb.PageLive do
  use DocsWeb, :live_view

  alias DocsWeb.Utils, as: Utils

  defp get_content(metadata, lang, tab, page) do
    Enum.find(metadata[lang][tab], fn p -> Enum.member?(Keyword.keys(p), page)  end)
  end

  defp get_title(pair) do
    key = elem(pair, 0)
    data = elem(pair, 1)

    title = if (Map.has_key?(data, :title)) do data[:title] else key end
    {key, title}
  end

  defp page_keys(metadata, lang) do
    Enum.into(metadata[lang][:subcategories], %{},
      fn {sec_name, sec_val} -> {
        sec_name,
        Enum.map(sec_val[:pages], fn pair -> get_title(pair) end)
      } end
    )
  end

  defp page_keys(metadata, lang, tab) do
    page_keys(metadata, lang)[tab]
  end

  defp get_content(lang, path) do
    file_name = "#{:code.priv_dir(:docs)}/docs/#{path}"
    cond do
      (String.ends_with?(path, ".toml")) ->
        ## TOML files
        {:ok, data} = Toml.decode_file(file_name, keys: :atoms)
        key = hd(Enum.map(data, fn({key, value}) -> key end))
        data[key]
      (String.ends_with?(path, ".md")) ->
        ## md files
        # Make links open in a new tab
        earmark_add_target = fn node -> Earmark.AstTools.merge_atts_in_node(node, target: "_blank") end
        earmark_options = [
          registered_processors: [
            {"a", earmark_add_target}
          ]
        ]

        {:ok, file} = File.open(file_name, [:read, :utf8])
        title = String.trim(IO.read(file, :line), "\n")
        contents = IO.read(file, :all)
        File.close(file)

        {status, html, error} = Earmark.as_html(contents, earmark_options)

        if status == :error do
          [{err_type, line_no, message}] = error
          if err_type == :warning do
            IO.puts(:stderr, "Warning when processing #{file_name} at line #{line_no}: #{message}")
          else
            IO.puts(:stderr, "Error when processing #{file_name} at line #{line_no}: #{message}")
          end
        end
        %{:html => html}
    end
  end

  @impl true
  def mount(params, %{"metadata" => metadata}, socket) do

    # Set default language, tab, and page
    active_lang = if (Map.has_key?(params, "active_lang")) do String.to_atom(params["active_lang"]) else :en end
    active_tab = if (Map.has_key?(params, "active_tab")) do String.to_atom(params["active_tab"]) else :synths end

    IO.puts "#{active_lang}/#{active_tab}"

    # try do
    active_pages = Enum.into(metadata[active_lang][:subcategories], %{}, fn {k, v} -> {k, Utils.ListUtils.first_or_nil(Enum.map(v[:pages], fn x -> elem(x,0) end))} end)
    active_page = if (Map.has_key?(params, :active_page)) do params[:active_page] else active_pages[active_tab] end

    {^active_page, info} = Enum.find(metadata[active_lang][:subcategories][active_tab][:pages], fn p -> (elem(p, 0) == active_page)  end)
    content = get_content(active_lang, info[:path])
    {
      :ok,
      assign(socket,
        metadata:     metadata,
        active_lang:  active_lang,
        active_tab:   active_tab,
        active_page:  active_page,
        active_pages: active_pages,
        page_keys:    page_keys(metadata, active_lang, active_tab),
        content:      content,
        slide_over:   false
      )
    }
    # rescue
    #   Protocol.UndefinedError ->
    #     raise DocsWeb.PageNotFoundError, "Error 404: Page not found"
    # end

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
    pages = socket.assigns.metadata[active_lang][:subcategories][active_tab][:pages]
    {^active_page, info} = Enum.find(pages, fn p -> (elem(p, 0) == active_page) end)
    content = get_content(active_lang, info[:path])
    {
      :noreply,
      assign(socket,
        active_lang:  active_lang,
        active_tab:   active_tab,
        active_pages: socket.assigns.active_pages,
        page_keys:    page_keys(socket.assigns.metadata, active_lang, active_tab),
        content:      content,
        slide_over:   false
      )
    }
  end

  def handle_event("show_slide_over", _value, socket) do
    active_lang = socket.assigns.active_lang
    active_tab = socket.assigns.active_tab
    active_page = socket.assigns.active_pages[active_tab]
    pages = socket.assigns.metadata[active_lang][:subcategories][active_tab][:pages]
    {^active_page, info} = Enum.find(pages, fn p -> (elem(p, 0) == active_page) end)
    content = get_content(active_lang, info[:path])
    {
      :noreply,
      assign(socket,
        active_lang:  active_lang,
        active_tab:   active_tab,
        active_pages: socket.assigns.active_pages,
        page_keys:    page_keys(socket.assigns.metadata, active_lang, active_tab),
        content:      content,
        slide_over:   true
      )
    }
  end

  def handle_event("close_slide_over", _value, socket) do
    active_lang = socket.assigns.active_lang
    active_tab = socket.assigns.active_tab
    active_page = socket.assigns.active_pages[active_tab]
    pages = socket.assigns.metadata[active_lang][:subcategories][active_tab][:pages]
    {^active_page, info} = Enum.find(pages, fn p -> (elem(p, 0) == active_page) end)
    content = get_content(active_lang, info[:path])
    {
      :noreply,
      assign(socket,
        active_lang:  active_lang,
        active_tab:   active_tab,
        active_pages: socket.assigns.active_pages,
        page_keys:    page_keys(socket.assigns.metadata, active_lang, active_tab),
        content:      content,
        slide_over:   false
      )
    }
  end

  @impl true
  def handle_event("change_page", %{"active_page" => active_page}, socket) do
    active_lang = socket.assigns.active_lang
    active_tab = socket.assigns.active_tab
    pages = socket.assigns.metadata[active_lang][:subcategories][active_tab][:pages]
    active_page = String.to_atom(active_page)
    {^active_page, info} = Enum.find(pages, fn p -> (elem(p, 0) == active_page) end)
    content = get_content(active_lang, info[:path])
    {
      :noreply,
      assign(socket,
        active_lang:  active_lang,
        active_pages: %{socket.assigns.active_pages | active_tab => active_page},
        content:      content,
        slide_over:   false
      )
    }
  end

  @impl true
  def handle_params(%{"active_lang" => active_lang, "active_tab" => active_tab, "active_page" => active_page}=_params, _uri, socket) do
    active_lang = String.to_atom(active_lang)
    active_tab = String.to_atom(active_tab)
    pages = socket.assigns.metadata[active_lang][:subcategories][active_tab][:pages]
    active_page = String.to_atom(active_page)
    {^active_page, info} = Enum.find(pages, fn p -> (elem(p, 0) == active_page) end)
    content = get_content(active_lang, info[:path])
    {
      :noreply,
      assign(socket,
        active_lang: active_lang,
        active_tab: active_tab,
        active_pages: %{socket.assigns.active_pages | active_tab => active_page},
        page_keys: page_keys(socket.assigns.metadata, active_lang, active_tab),
        content: content,
        slide_over:   false
      )
    }
  end

  @impl true
  def handle_params(%{"active_lang" => active_lang, "active_tab" => active_tab}=_params, _uri, socket) do
    active_lang = String.to_atom(active_lang)
    active_tab = String.to_atom(active_tab)
    try do
      active_page = socket.assigns.active_pages[active_tab]
      pages = socket.assigns.metadata[active_lang][:subcategories][active_tab][:pages]
      {^active_page, info} = Enum.find(pages, fn p -> (elem(p, 0) == active_page) end)
      content = get_content(active_lang, info[:path])
      {
        :noreply,
        assign(socket,
          active_lang: active_lang,
          active_tab: active_tab,
          active_pages: socket.assigns.active_pages,
          page_keys: page_keys(socket.assigns.metadata, active_lang, active_tab),
          content: content,
          slide_over:   false
        )
      }
    rescue
      Protocol.UndefinedError ->
        raise DocsWeb.PageNotFoundError, "Error 404: Page not found"
    end
  end

  @impl true
  def handle_params(%{"active_lang" => active_lang}=_params, _uri, socket) do
    active_lang = String.to_atom(active_lang)
    try do
      # Test to see if the language is valid
      pages = socket.assigns.metadata[active_lang][:subcategories][:tutorial][:pages]
      # Show welcome page
      {:noreply, assign(socket, active_lang: active_lang, active_tab: :home, active_page: :welcome, content: nil)}
    rescue
      Protocol.UndefinedError ->
        raise DocsWeb.PageNotFoundError, "Error 404: Page not found"
    end

  end

  @impl true
  def handle_params(params, _uri, socket) do
    if(map_size(params) == 0) do
      # Show welcome page
      {:noreply, assign(socket, active_tab: :home, active_page: :welcome, content: nil, slide_over: false)}
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
