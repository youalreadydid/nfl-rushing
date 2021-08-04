defmodule NflRushingWeb.RushingStatisticsLive do
  @moduledoc false

  use NflRushingWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    Process.send(self(), :update, [])

    {:ok, assign(socket, rushing_statistics: [])}
  end

  @impl true
  def handle_info(:update, socket) do
    stat = %NflRushing.RushingStatistics{
      name: "Shane Vereen",
      team: "NYG",
      position: "RB",
      attemps: 33,
      attemps_per_game_average: 6.6,
      total_yards: 158,
      average_yards_per_attempt: 4.8,
      yards_per_game: 31.6,
      total_touchdowns: 1,
      longest_rush: "25",
      first_downs: 8,
      first_down_percentage: 24.2,
      yards_each_20_plus: 1,
      yards_each_40_plus: 0,
      fumbles: 1
    }

    {:noreply, assign(socket, rushing_statistics: [stat])}
  end
end
