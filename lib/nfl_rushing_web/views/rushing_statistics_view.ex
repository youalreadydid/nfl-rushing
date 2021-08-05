defmodule NflRushingWeb.RushingStatisticsView do
  use NflRushingWeb, :view
  alias NflRushing.RushingStatistics

  def render("index.csv", %{rushing_statistics: rushing_statistics}) do
    render_many(rushing_statistics, __MODULE__, "rushing_statistics.csv")
  end

  def render("rushing_statistics.csv", %{rushing_statistics: %RushingStatistics{} = stat}) do
    touchdown = if stat.longest_rush_touchdown, do: "T"
    longest_rush = "#{stat.longest_rush}#{touchdown}"

    [
      stat.name,
      stat.team,
      stat.position,
      stat.attemps,
      stat.attemps_per_game_average,
      stat.total_yards,
      stat.average_yards_per_attempt,
      stat.yards_per_game,
      stat.total_touchdowns,
      longest_rush,
      stat.first_downs,
      stat.first_down_percentage,
      stat.yards_each_20_plus,
      stat.yards_each_40_plus,
      stat.fumbles
    ]
  end
end
