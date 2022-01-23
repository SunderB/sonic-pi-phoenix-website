require JSON

defmodule DocsWeb.Utils.JSONUtils do
  def write_json(data, filename) do
    {status, json_result} = JSON.encode(data)
    # Open the file in read, write and utf8 modes.
    file = File.open!(filename, [:utf8, :write])
    # Write to this "io_device" using standard IO functions
    IO.puts(file, json_result)
    File.close(file)
  end
end
