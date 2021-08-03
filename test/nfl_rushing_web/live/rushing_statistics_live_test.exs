defmodule NflRushingWeb.RushingStatisticsLiveTest do
  use NflRushingWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected render", %{conn: conn} do
    {:ok, _rushing_statistics_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "NFL Rushing"
  end

  test "connected render", %{conn: conn} do
    {:ok, rushing_statistics_live, disconnected_html} = live(conn, "/")
    assert render(rushing_statistics_live) =~ "Player</th><th>Team</th><th>Pos</th>"
  end
end
