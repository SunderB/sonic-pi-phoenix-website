defmodule DocsWeb.PageNotFoundError do
  defexception [:message, plug_status: 404]
end
