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

  test "renders a rushing statistics", %{conn: conn} do
    stat = build(:rushing_statistics)
    {:ok, live, _disconnected} = live(conn, "/")
    assert render(live) =~ "<td>#{stat.name}</td>"
  end
end
