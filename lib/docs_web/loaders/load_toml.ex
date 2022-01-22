require IEx

defmodule DocsWeb.Loaders.LoadTOML do

  defp file_list(dir) do
    #IO.puts "#{:code.priv_dir(:docs)}/toml/#{dir}/*.toml"
    toml = Path.wildcard("#{:code.priv_dir(:docs)}/toml/#{dir}/*.toml")
    Enum.map(toml, fn file ->
      {:ok, data} = Toml.decode_file(file, keys: :atoms)
      data
    end)
  end

  @doc """
    Creates a map of contents for the whole site
  """
  def toml_directory_list do
    lang_dirs = File.cd!(
      "#{:code.priv_dir(:docs)}/toml",
      #fn -> File.ls! |> Enum.filter(&File.dir?(Path.join("#{:code.priv_dir(:docs)}/toml", &1))) end
      fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join("#{:code.priv_dir(:docs)}/toml", x)) && (x != "_build")) end) end
    )
    #IO.puts(inspect(lang_dirs))

    dir_list = for lang <- lang_dirs, into: %{} do
      dirs = File.cd!(
        "#{:code.priv_dir(:docs)}/toml/#{lang}",
        #fn -> File.ls! |> Enum.filter(&File.dir?(Path.join("#{:code.priv_dir(:docs)}/toml/#{lang}/", &1))) end
        fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join("#{:code.priv_dir(:docs)}/toml/#{lang}", x)) && (x != "_build")) end) end
      )

      sub_list = for(dir <- dirs, into: %{}, do: {String.to_atom(dir), file_list("#{lang}/#{dir}")})
      #IO.puts(inspect(sub_list))
      {String.to_atom(lang), sub_list}
    end

    #IO.puts(inspect(dir_list))
    dir_list
  end

  # def metadata(f) do
  #   key = make_ref()
  #   fn ->
  #     case :ets.lookup(:session, key) do
  #       [{^key, val}] -> val
  #       [] ->
  #         val = f.()
  #         :ets.insert(:session, {key, val})
  #         #IO.inspect(val)
  #         val
  #     end
  #   end
  # end

  def init(default), do: default

  # def call(conn, _default) do
  #     conn
  #     |> put_session(:toml_metadata, metadata(&directory_list/0).())
  # end
end
