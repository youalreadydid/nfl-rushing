defmodule NflRushingWeb.RushingStatisticsLive do
  @moduledoc false

  use NflRushingWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, rushing_statistics: [])}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    stats = NflRushing.search_rushing_statistics(params["search"])
    {:noreply, assign(socket, rushing_statistics: stats)}
  end
end
