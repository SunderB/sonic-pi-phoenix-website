require IEx

defmodule DocsWeb.PageView do
  use DocsWeb, :view

  # def to_string(x) do
  #   if is_atom(x) do
  #     Atom.to_string(x)
  #   else
  #     x
  #   end
  # end

  def is_active(tab, which_tab) do
    if tab != nil && tab == which_tab do
      true
    else
      false
    end
  end

  def sample_path(example) do
    sample_name = sample_name(example)
    "/static_assets/samples/#{sample_name}.flac"
  end

  def sample_name(example) do
    prefix = "sample :"
    base = byte_size(prefix)
    <<_::binary-size(base), rest::binary>> = example
    rest
  end

  def get_page_title(pair) do
    key = elem(pair, 0)
    data = elem(pair, 1)

    title = if (Map.has_key?(data, :title)) do data[:title] else key end
    {key, title}
  end

  def page_keys(metadata, lang) do
    Enum.into(metadata[lang][:subcategories], %{},
      fn {sec_name, sec_val} -> {
        sec_name,
        Enum.map(sec_val[:pages], fn pair -> get_page_title(pair) end)
      } end
    )
  end

  def get_langs() do
    File.cd!(
      "#{:code.priv_dir(:docs)}/docs",
      fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join("#{:code.priv_dir(:docs)}/docs", x)) && (x != "_build")) end) end
    )
  end

  def nav_entries(assigns) do
    # assigns = assign(assigns[:socket], assigns)
    Enum.into(assigns[:metadata][assigns[:active_lang]][:subcategories], [],
      fn {sec_name, _sec_val} ->
        assigns = Map.put(assigns, :sec_name, sec_name)
        %{heading: String.capitalize(Atom.to_string(sec_name)),
          content: ~H"""
          <.tabs class="flex-col">
          <%= for {page, title} <- page_keys(@metadata, @active_lang)[@sec_name] do %>
            <%= if is_active(@active_page, page) and is_active(@active_tab, @sec_name) do %>
              <%= if (String.match?(to_string(title), ~r/^([0-9A-Z]){1,2}.([0-9])+/)) do %>
                <.link class="sub_page active_page" aria-current="page" patch={Routes.live_path(@socket, DocsWeb.PageLive, @active_lang, @sec_name, page)}><%= title %></.link>
              <% else %>
                <.link class="active_page" aria-current="page" patch={Routes.live_path(@socket, DocsWeb.PageLive, @active_lang, @sec_name, page)}><%= title %></.link>
              <% end %>
            <% else %>
              <%= if (String.match?(to_string(title), ~r/^([0-9A-Z]){1,2}.([0-9])+/)) do %>
              <.link class="sub_page" aria-current="page" patch={Routes.live_path(@socket, DocsWeb.PageLive, @active_lang, @sec_name, page)}><%= title %></.link>
              <% else %>
              <.link aria-current="page" patch={Routes.live_path(@socket, DocsWeb.PageLive, @active_lang, @sec_name, page)}><%= title %></.link>
              <% end %>
            <% end %>
          <% end %>
          </.tabs>
          """
        }
      end
    )
  end
end
