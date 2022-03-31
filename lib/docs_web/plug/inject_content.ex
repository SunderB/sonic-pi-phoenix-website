require IEx
require JSON

defmodule DocsWeb.Plug.InjectContent do
  import Plug.Conn
  alias DocsWeb.Utils, as: Utils

  defp _debug_write_json(data, filename) do
    {status, json_result} = JSON.encode(data)
    # Open the file in read, write and utf8 modes.
    file = File.open!(filename, [:utf8, :write])
    # Write to this "io_device" using standard IO functions
    IO.puts(file, json_result)
    File.close(file)
  end

  defp file_list(dir) do
    IO.puts(dir)
    md = Path.wildcard("#{dir}/*.md")
    toml = Path.wildcard("#{dir}/*.toml")

    ## Markdown files
    # Make links open in a new tab
    earmark_add_target = fn node -> Earmark.AstTools.merge_atts_in_node(node, target: "_blank") end
    earmark_options = [
      registered_processors: [
        {"a", earmark_add_target}
      ]
    ]

    md_file_list = for file_name <- md, into: [] do
      {:ok, file} = File.open(file_name, [:read, :utf8])
      title = String.trim(IO.read(file, :line), "\n")
      contents = IO.read(file, :all)

      {status, html, error} = Earmark.as_html(contents, earmark_options)

      if status == :error do
        [{err_type, line_no, message}] = error
        if err_type == :warning do
          IO.puts(:stderr, "Warning when processing #{file_name} at line #{line_no}: #{message}")
        else
          IO.puts(:stderr, "Error when processing #{file_name} at line #{line_no}: #{message}")
        end

      end
      name = String.to_atom(Path.basename(file_name, ".md"))
      content = %{:title => title, :html => html}
      {name, content}
    end

    ## TOML files
    toml_file_list = for file_name <- toml, into: [] do
      {:ok, data} = Toml.decode_file(file_name, keys: :atoms)
      key = hd(Enum.map(data, fn({key, value}) -> key end))
      {key, data[key]}
    end

    # Combine the lists of md and toml files together
    file_map = Enum.concat(md_file_list, toml_file_list)
    #IO.inspect(file_map)

    # Recurse through subdirectories
    subdirs = File.cd!(
      dir,
      fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join(dir, x)) && (x != "_build")) end) end
    )
    sub_list = for(d <- subdirs, into: [], do: {String.to_atom(d), file_list("#{dir}/#{d}")})

    # Return the list of pages and subcategories
    %{:pages => file_map, :subcategories => Map.new(sub_list)}
  end

  @doc """
    Creates a map of contents for all the pages generated from the documentation files
  """
  def directory_list do
    lang_dirs = File.cd!(
      "#{:code.priv_dir(:docs)}/docs",
      fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join("#{:code.priv_dir(:docs)}/docs", x)) && (x != "_build")) end) end
    )

    dir_list = for lang <- lang_dirs, into: %{} do
      {String.to_atom(lang), file_list("#{:code.priv_dir(:docs)}/docs/#{lang}")}
    end

    # For debugging
    # Utils.JSONUtils.write_json(dir_list, "contents.json")

    dir_list
  end

  def metadata(f) do
    key = make_ref()
    fn ->
      case :ets.lookup(:session, key) do
        [{^key, val}] -> val
        [] ->
          val = f.()
          :ets.insert(:session, {key, val})
          #IO.inspect(key)
          val
      end
    end
  end

  def init(default), do: default

  def call(conn, _default) do
    put_session(conn, :metadata, metadata(&directory_list/0).())
  end
end
