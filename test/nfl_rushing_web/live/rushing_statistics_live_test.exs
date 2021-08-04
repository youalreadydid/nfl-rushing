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

  test "renders some rushing statistics", %{conn: conn} do
    stat_one = insert!(:rushing_statistics)
    stat_two = insert!(:rushing_statistics, %{name: "Max Smith"})
    {:ok, live, _disconnected} = live(conn, "/")

    assert render(live) =~ "<td>#{stat_one.name}</td>"
    assert render(live) =~ "<td>#{stat_two.name}</td>"
  end
end
