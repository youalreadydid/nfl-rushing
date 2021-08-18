defmodule NflRushingWeb.RushingTeamStatisticsLiveTest do
  use NflRushingWeb.ConnCase
  import Phoenix.LiveViewTest

  test "renders title and empty statistics table when disconnected", %{conn: conn} do
    {:ok, _live, disconnected} = live(conn, "/team")
    assert disconnected =~ "Team Statistics"
    assert disconnected =~ "</td></tr></table>"
  end

  test "renders no statistics", %{conn: conn} do
    {:ok, live, _disconnected} = live(conn, "/team")
    assert render(live) =~ "</td></tr></table>"
  end

  test "renders all rushing statistics for a team", %{conn: conn} do
    _stat_one =
      insert!(:rushing_statistics, %{
        name: "John Stone",
        team: "NYG",
        total_yards: 100,
        longest_rush: 10
      })

    _stat_two =
      insert!(:rushing_statistics, %{
        name: "Max Smith",
        team: "NYG",
        total_yards: 50,
        longest_rush: 4
      })

    _stat_three =
      insert!(:rushing_statistics, %{
        name: "John Stone",
        team: "ANO",
        total_yards: 300,
        longest_rush: 3
      })

    _stat_four =
      insert!(:rushing_statistics, %{
        name: "Max Smith",
        team: "ANO",
        total_yards: 100,
        longest_rush: 9
      })

    {:ok, live, _disconnected} = live(conn, "/team")

    assert render(live) =~ "<th>Team</th><th>Total Yds</th><th>Lng</th>"
    assert render(live) =~ "<td>NYG</td><td>150</td><td>10</td>"
    assert render(live) =~ "<td>ANO</td><td>400</td><td>9</td>"
  end
end
