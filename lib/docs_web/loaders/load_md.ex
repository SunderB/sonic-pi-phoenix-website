require IEx

defmodule DocsWeb.Loaders.LoadMarkdown do

  defp file_list(dir) do
    #IO.puts "#{:code.priv_dir(:docs)}/md/#{dir}/*.md"
    md = Path.wildcard("#{:code.priv_dir(:docs)}/md/#{dir}/*.md")
    options = [
      registered_processors: [
        # {"a", [{"href", "url"}, {"target", "_blank"}], nil, nil}},
        # {"p", &Earmark.AstTools.merge_atts_in_node(&1, class: "example")}
      ]
    ]
    Enum.map(md, fn file_name ->
      {:ok, file} = File.open(file_name, [:read, :write])
      title = String.trim(IO.read(file, :line), "\n")
      contents = IO.read(file, :all)

      {status, html, error} = Earmark.as_html(contents, options)

      if status == :error do
        [{err_type, line_no, message}] = error
        if err_type == :warning do
          IO.puts(:stderr, "Warning when processing #{file_name} at line #{line_no}: #{message}")
        else
          IO.puts(:stderr, "Error when processing #{file_name} at line #{line_no}: #{message}")
        end

      end
      %{String.to_atom(Path.basename(file_name, ".md")) => %{:title => title, :html => html}}
    end)
  end

  @doc """
    Creates a map of contents for the whole site
  """
  def md_directory_list do
    lang_dirs = File.cd!(
      "#{:code.priv_dir(:docs)}/md",
      fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join("#{:code.priv_dir(:docs)}/md", x)) && (x != "_build")) end) end
    )
    #IO.puts(inspect(lang_dirs))

    dir_list = for lang <- lang_dirs, into: %{} do
      dirs = File.cd!(
        "#{:code.priv_dir(:docs)}/md/#{lang}",
        #fn -> File.ls! |> Enum.filter(&File.dir?(Path.join("#{:code.priv_dir(:docs)}/md/#{lang}/", &1))) end
        fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join("#{:code.priv_dir(:docs)}/md/#{lang}", x)) && (x != "_build")) end) end
      )

      sub_list = for(dir <- dirs, into: %{}, do: {String.to_atom(dir), file_list("#{lang}/#{dir}")})
      #IO.puts(inspect(sub_list))
      {String.to_atom(lang), sub_list}
    end

    IO.puts(inspect(dir_list))
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
  #         IO.puts(inspect(val))
  #         val
  #     end
  #   end
  # end

  # def merge_metadata(old_metadata) do
  #   new_metadata = old_metadata
  #   md_metadata = metadata(&directory_list/0).()
  #   languages = Enum.concat(Map.keys(old_metadata), Map.keys(md_metadata))
  #   # sections = Map.keys(md_metadata[:en])

  #   # if (new_metadata != nil) do

  #   # else
  #   #   new_metadata = md_metadata
  #   # end

  #   # for lang <- Map.keys(md_metadata) do
  #   #   for section <- Map.keys(md_metadata[lang]) do
  #   #     IO.puts("Inserting for #{lang} #{section}: #{Enum.count(md_metadata[lang][section])} pages")
  #   #     #if (Map.has_key?(new_metadata[lang], section)) do
  #   #     #  Map.put(new_metadata[lang], section, Map.merge(old_metadata[lang][section], md_metadata[lang][section]))
  #   #     #else

  #   #     #end
  #   #   end
  #   # end
  #   #IO.puts(md_metadata[:en][:tutorial])
  #   #new_metadata

  #   Enum.map(languages, fn(lang) ->
  #     if Map.has_key?(md_metadata, :examples) do
  #       IO.puts(lang)
  #       Map.merge(old_metadata[lang], md_metadata[lang])
  #     else
  #       old_metadata[lang]
  #     end
  #   end)
  # end

  def init(default), do: default

  # def call(conn, _default) do
  #   #IO.puts(get_session(conn, :metadata))
  #   conn
  #   |> put_session(:md_metadata, metadata(&directory_list/0).())
  #   #merge_metadata(get_session(conn, :metadata))
  # end
end
