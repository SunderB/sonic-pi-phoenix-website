require IEx

defmodule DocsWeb.PageView do
  use DocsWeb, :view

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
    Enum.into(assigns[:metadata][assigns[:active_lang]][:subcategories], [],
      fn {sec_name, sec_val} -> %{
        heading: String.capitalize(Atom.to_string(sec_name)),
        content: ~H"""
        <.tabs class="flex-col">
        <%= for {page, title} <- page_keys(@metadata, @active_lang)[sec_name] do %>
          <%= if is_active(@active_page, page) and is_active(@active_tab, sec_name) do %>
            <.tab link_type="live_patch" aria-current="page" to={Routes.live_path(@socket, DocsWeb.PageLive, @active_lang, sec_name, page)} is_active label={title}/>
          <% else %>
            <.tab link_type="live_patch" aria-current="page" to={Routes.live_path(@socket, DocsWeb.PageLive, @active_lang, sec_name, page)} label={title}/>
          <% end %>
        <% end %>
        </.tabs>
        """
      }
      end
    )
  end
end
