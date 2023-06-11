defmodule DocsWeb.Plug.InjectContent do
  import Plug.Conn

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
    put_session(conn, :metadata, Application.get_env(:docs, :toc))
  end
end
