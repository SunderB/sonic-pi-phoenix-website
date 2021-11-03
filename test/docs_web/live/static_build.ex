defmodule DocsWeb.StaticBuildTest do
  use DocsWeb.ConnCase
  import Plug.Conn
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  import DocsWeb.Plug.InjectToml

  @shortdoc "Simply calls the Hello.say/0 function."
  def generate_html_pages_for_folder(conn, src_folder, destination_folder) do
    # toml = Path.wildcard("#{:code.priv_dir(:docs)}/toml/#{section}/*.toml")
    # toml_list = Enum.map(toml, fn file ->
    #   route_path = "/#{section}/#{Path.basename(file, ".toml")}"
    #   destination_path = Path.join([
    #     destination_folder,
    #     section,
    #     Path.basename(file, "")
    #   ])
    #   {route_path, destination_path}
    # end)

    toml = Path.wildcard("#{src_folder}/*.toml")
    toml_list = Enum.map(toml, fn file ->
      route_dir = Path.dirname(String.replace(file, Path.expand("#{:code.priv_dir(:docs)}/toml/"), ""))
      route_path = Path.join([
          route_dir,
          Path.basename(file, ".toml")
      ])
      destination_path = Path.join([
        destination_folder,
        route_dir,
        "#{Path.basename(file, ".toml")}.html"
      ])
      {route_path, destination_path}
    end)

    md = Path.wildcard("#{src_folder}/*.md")
    md_list = Enum.map(md, fn file ->
      route_dir = Path.dirname(String.replace(file, Path.expand("#{:code.priv_dir(:docs)}/md/"), ""))
      route_path = Path.join([
          route_dir,
          Path.basename(file, ".md")
      ])
      destination_path = Path.join([
        destination_folder,
        route_dir,
        "#{Path.basename(file, ".md")}.html"
      ])
      {route_path, destination_path}
    end)

    for {route_path, dest} <- List.flatten(toml_list, md_list) do
      generate_html_page_for_route(conn, route_path, dest)
    end

  end

  def generate_html_page_for_route(conn, route_path, destination_path) do
    IO.puts("Generating '#{route_path}'")
    conn = get(conn, route_path, css_path: "test")
    resp = Phoenix.ConnTest.html_response(conn, 200)

    assert File.mkdir_p(Path.dirname(destination_path)) == :ok

    {:ok, file} = File.open(destination_path, [:write])
    assert IO.binwrite(file, resp) == :ok
    File.close(file)
  end


  test "generate static site", %{conn: conn} do
    # calling our Hello.say() function from earlier
    dirs = File.cd!(
      "#{:code.priv_dir(:docs)}/toml",
      fn -> File.ls! |> Enum.filter(&File.dir?(Path.join("#{:code.priv_dir(:docs)}/toml", &1))) end
    )

    File.rm_rf("#{:code.priv_dir(:docs)}/_site/")

    assert IO.puts("\ndirs: #{inspect(dirs)}") == :ok
    for dir <- dirs do
      if (dir != "_build") do
        generate_html_pages_for_folder(conn, "#{:code.priv_dir(:docs)}/toml/#{dir}", "#{:code.priv_dir(:docs)}/_site/")
      end
    end

  end
end
