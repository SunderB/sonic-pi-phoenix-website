defmodule DocsWeb.PageLiveTest do
  use DocsWeb.ConnCase
  import Plug.Conn
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest

  test "disconnected and connected mount", %{conn: conn} do
    conn = get(conn, "/fx/bitcrusher")
    assert html_response(conn, 200) =~ "<h1>My Disconnected View</h1>"

    {:ok, view, html} = live(conn)
  end

  test "redirected mount", %{conn: conn} do
    assert {:error, {:redirect, %{to: "/somewhere"}}} = live(conn, "my-path")
  end
end
