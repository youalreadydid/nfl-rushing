defmodule NflRushingWeb.RushingTeamStatisticsLiveTest do
  use NflRushingWeb.ConnCase
  import Phoenix.LiveViewTest

  test "renders title and empty statistics table when disconnected", %{conn: conn} do
    {:ok, _live, disconnected} = live(conn, "/team")
    assert disconnected =~ "Team Statistics"
    assert disconnected =~ "</th></tr></table>"
  end

  test "renders no statistics", %{conn: conn} do
    {:ok, live, _disconnected} = live(conn, "/team")
    assert render(live) =~ "</th></tr></table>"
  end
end
