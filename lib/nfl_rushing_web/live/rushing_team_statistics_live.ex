defmodule NflRushingWeb.RushingTeamStatisticsLive do
  @moduledoc false
  use NflRushingWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    stats = NflRushing.list_aggregated_rushing_statistics_by_team()

    {:ok, assign(socket, rushing_statistics: stats)}
  end
end
