require IEx
require JSON

defmodule DocsWeb.ContentIndexer do
  use GenServer, restart: :temporary # Only run once
  alias DocsWeb.Utils, as: Utils

  defp _debug_write_json(data, filename) do
    {_status, json_result} = JSON.encode(data)
    # Open the file in read, write and utf8 modes.
    file = File.open!(filename, [:utf8, :write])
    # Write to this "io_device" using standard IO functions
    IO.puts(file, json_result)
    File.close(file)
  end

  defp file_list(dir, root_dir) do
    IO.puts(dir)
    md = Path.wildcard("#{dir}/*.md")
    toml = Path.wildcard("#{dir}/*.toml")

    ## Markdown files
    md_file_list = for file_name <- md, into: [] do
      {:ok, file} = File.open(file_name, [:read, :utf8])
      title = String.trim(IO.read(file, :line), "\n")
      File.close(file)

      name = String.to_atom(Path.basename(file_name, ".md"))
      info = %{:title => title, :path => Path.relative_to(file_name, root_dir)}
      {name, info}
    end

    ## TOML files
    toml_file_list = for file_name <- toml, into: [] do
      {:ok, data} = Toml.decode_file(file_name, keys: :atoms)
      key = hd(Enum.map(data, fn({key, _value}) -> key end))
      info = %{:title => key, :path => Path.relative_to(file_name, root_dir)}
      {key, info}
    end

    # Combine the lists of md and toml files together
    file_map = Enum.concat(md_file_list, toml_file_list)

    # Recurse through subdirectories
    subdirs = File.cd!(
      dir,
      fn -> File.ls! |> Enum.filter(fn x -> (File.dir?(Path.join(dir, x)) && (x != "LC_MESSAGES") && (x != "_build")) end) end
    )
    sub_list = for(d <- subdirs, into: [], do: {String.to_atom(d), file_list("#{dir}/#{d}", root_dir)})

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
      {String.to_atom(lang), file_list("#{:code.priv_dir(:docs)}/docs/#{lang}", "#{:code.priv_dir(:docs)}/docs")}
    end

    # For debugging
    # Utils.JSONUtils.write_json(dir_list, "contents.json")

    dir_list
  end

  def index_pages() do
    Application.put_env(:docs, :toc, directory_list(), persistent: true)
  end

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(state) do
    IO.inspect "Indexing content..."
    Application.put_env(:docs, :toc, directory_list(), persistent: true)
    IO.inspect "Done indexing"

    # Process will send :timeout to self after 1 second
    {:ok, state, 1000}
  end

  @impl true
  def handle_info(:timeout, state) do
    # Stop this process, because it's temporary it will not be restarted
    IO.inspect "Terminating indexer..."
    {:stop, :normal, state}
  end
end
