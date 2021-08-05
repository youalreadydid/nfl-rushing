defmodule NflRushingWeb.RushingStatisticsViewTest do
  use NflRushingWeb.ConnCase, async: true
  import Phoenix.View

  alias NflRushingWeb.RushingStatisticsView

  describe "render/1 for rushing_statistics.csv" do
    test "renders a rushing statistics" do
      stat = build(:rushing_statistics, %{longest_rush_touchdown: false})

      assert render(RushingStatisticsView, "rushing_statistics.csv", rushing_statistics: stat) ==
               ["Shane Vereen", "NYG", "RB", 33, 6.6, 158, 4.8, 31.6, 1, "25", 8, 24.2, 1, 0, 1]
    end

    test "renders a rushing statistics with longest rush touchdown" do
      stat = build(:rushing_statistics, %{longest_rush_touchdown: true})

      assert render(RushingStatisticsView, "rushing_statistics.csv", rushing_statistics: stat) ==
               ["Shane Vereen", "NYG", "RB", 33, 6.6, 158, 4.8, 31.6, 1, "25T", 8, 24.2, 1, 0, 1]
    end
  end

  describe "render/1 for index.csv" do
    test "renders all rushing statistics" do
      stat_one = build(:rushing_statistics, %{longest_rush_touchdown: false})
      stat_two = build(:rushing_statistics, %{longest_rush_touchdown: true})
      stats = [stat_one, stat_two]
      rendered_stats = render(RushingStatisticsView, "index.csv", rushing_statistics: stats)

      assert rendered_stats == [
               ["Shane Vereen", "NYG", "RB", 33, 6.6, 158, 4.8, 31.6, 1, "25", 8, 24.2, 1, 0, 1],
               ["Shane Vereen", "NYG", "RB", 33, 6.6, 158, 4.8, 31.6, 1, "25T", 8, 24.2, 1, 0, 1]
             ]
    end
  end
end
