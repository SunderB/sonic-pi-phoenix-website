require IEx

defmodule DocsWeb.PageView do
  use DocsWeb, :view

  def is_active(tab, which_tab) do
    if tab != nil && tab == which_tab do
      "nav-link active"
    else
      "nav-link"
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
end
