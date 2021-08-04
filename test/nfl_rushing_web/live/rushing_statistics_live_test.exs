defmodule NflRushingWeb.RushingStatisticsLiveTest do
  use NflRushingWeb.ConnCase
  import Phoenix.LiveViewTest
  import Mock

  test "renders title and empty statistics table when disconnected", %{conn: conn} do
    {:ok, _live, disconnected} = live(conn, "/")
    assert disconnected =~ "NFL Rushing"
    assert disconnected =~ "<tr></tr>"
  end

  test "renders no statistics", %{conn: conn} do
    with_mock NflRushing, list_rushing_statistics: fn -> [] end do
      {:ok, live, _disconnected} = live(conn, "/")
      assert render(live) =~ "<tr></tr>"
    end
  end

  test "renders a rushing statistics", %{conn: conn} do
    stat = build(:rushing_statistics)
    {:ok, live, _disconnected} = live(conn, "/")
    assert render(live) =~ "<td>#{stat.name}</td>"
  end
end
