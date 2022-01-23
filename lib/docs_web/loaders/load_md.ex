require IEx

defmodule DocsWeb.Loaders.LoadMarkdown do

  @doc """
    Loads all markdown files in the directory, extracts the title, converts the file to html, and puts the title & html in a list/map of pages.
  """
  defp file_list(dir) do
    md = Path.wildcard("#{:code.priv_dir(:docs)}/md/#{dir}/*.md")

    # Make links open in a new tab
    add_target = fn node -> Earmark.AstTools.merge_atts_in_node(node, target: "_blank") end
    options = [
      registered_processors: [
        {"a", add_target}
      ]
    ]

    Enum.map(md, fn file_name ->
      {:ok, file} = File.open(file_name, [:read, :utf8])
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
    Creates a map of contents for all the pages generated from markdown files
  """
  def md_directory_list do
    lang_dirs = File.cd!(
      "#{:code.priv_dir(:docs)}/md",
      fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join("#{:code.priv_dir(:docs)}/md", x)) && (x != "_build")) end) end
    )

    dir_list = for lang <- lang_dirs, into: %{} do
      dirs = File.cd!(
        "#{:code.priv_dir(:docs)}/md/#{lang}",
        fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join("#{:code.priv_dir(:docs)}/md/#{lang}", x)) && (x != "_build")) end) end
      )

      sub_list = for(dir <- dirs, into: %{}, do: {String.to_atom(dir), file_list("#{lang}/#{dir}")})
      {String.to_atom(lang), sub_list}
    end
  end

  def init(default), do: default

end
