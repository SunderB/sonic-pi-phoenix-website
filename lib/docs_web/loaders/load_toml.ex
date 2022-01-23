require IEx

defmodule DocsWeb.Loaders.LoadTOML do

  @doc """
    Loads all TOML files in a folder, decodes them, then puts the data into a list/map of pages.
  """
  defp file_list(dir) do
    toml = Path.wildcard("#{:code.priv_dir(:docs)}/toml/#{dir}/*.toml")
    Enum.map(toml, fn file ->
      {:ok, data} = Toml.decode_file(file, keys: :atoms)
      data
    end)
  end

  @doc """
    Creates a map of contents for all pages generated from TOML files
  """
  def toml_directory_list do
    lang_dirs = File.cd!(
      "#{:code.priv_dir(:docs)}/toml",
      fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join("#{:code.priv_dir(:docs)}/toml", x)) && (x != "_build")) end) end
    )

    dir_list = for lang <- lang_dirs, into: %{} do
      dirs = File.cd!(
        "#{:code.priv_dir(:docs)}/toml/#{lang}",
        fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join("#{:code.priv_dir(:docs)}/toml/#{lang}", x)) && (x != "_build")) end) end
      )

      sub_list = for(dir <- dirs, into: %{}, do: {String.to_atom(dir), file_list("#{lang}/#{dir}")})
      {String.to_atom(lang), sub_list}
    end
  end

  def init(default), do: default

end
