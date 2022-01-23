require IEx
require JSON

defmodule DocsWeb.Plug.InjectContent do
  import Plug.Conn
  import DocsWeb.Loaders.LoadMarkdown
  import DocsWeb.Loaders.LoadTOML

  alias DocsWeb.Utils, as: Utils

  defp _debug_write_json(data, filename) do
    {status, json_result} = JSON.encode(data)
    # Open the file in read, write and utf8 modes.
    file = File.open!(filename, [:utf8, :write])
    # Write to this "io_device" using standard IO functions
    IO.puts(file, json_result)
    File.close(file)
  end

  def directory_list() do
    dir_list = Utils.MapUtils.deep_merge(toml_directory_list(), md_directory_list())

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
          #IO.inspect(val)
          val
      end
    end
  end

  def init(default), do: default

  def call(conn, _default) do
      conn
      |> put_session(:metadata, metadata(&directory_list/0).())
  end
end
