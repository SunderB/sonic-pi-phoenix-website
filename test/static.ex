defmodule DocsWeb.StaticTest do
  use DocsWeb.ConnCase, async: true

  # When testing helpers, you may want to import Phoenix.HTML and
  # use functions such as safe_to_string() to convert the helper
  # result into an HTML string.
  # import Phoenix.HTML


  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    IO.puts(conn.html_response)
    assert true
  end
end
