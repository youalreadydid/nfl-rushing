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
    stat = NflRushing.Fixtures.build(:rushing_statistics)
    {:noreply, assign(socket, rushing_statistics: [stat])}
  end
end
