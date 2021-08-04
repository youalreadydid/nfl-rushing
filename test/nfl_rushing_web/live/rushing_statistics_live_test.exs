defmodule NflRushingWeb.RushingStatisticsLiveTest do
  use NflRushingWeb.ConnCase
  import Phoenix.LiveViewTest

  test "renders title and empty statistics table when disconnected", %{conn: conn} do
    {:ok, _live, disconnected} = live(conn, "/")
    assert disconnected =~ "NFL Rushing"
    assert disconnected =~ "<tr></tr>"
  end

  test "renders no statistics", %{conn: conn} do
    {:ok, live, _disconnected} = live(conn, "/")
    assert render(live) =~ "<tr></tr>"
  end

  test "renders all rushing statistics", %{conn: conn} do
    _stat_one = insert!(:rushing_statistics, %{name: "John Stone"})
    _stat_two = insert!(:rushing_statistics, %{name: "Max Smith"})
    {:ok, live, _disconnected} = live(conn, "/")

    assert render(live) =~ "<td>John Stone</td>"
    assert render(live) =~ "<td>Max Smith</td>"
  end

  test "renders only searched players' rushing statistics", %{conn: conn} do
    _stat_one = insert!(:rushing_statistics, %{name: "John Stone"})
    _stat_two = insert!(:rushing_statistics, %{name: "Max Smith"})
    {:ok, live, _disconnected} = live(conn, "/?search=john")

    assert render(live) =~ "<td>John Stone</td>"
    refute render(live) =~ "<td>Max Smith</td>"
  end

  describe "handle_event/2 for search" do
    test "redirects to searched players' rushing statistics", %{conn: conn} do
      {:ok, live, _disconnected} = live(conn, "/")

      {:error, {:live_redirect, %{kind: :push, to: "/?search=john"}}} =
        live
        |> element("form")
        |> render_submit(%{q: "john"})
    end
  end
end
