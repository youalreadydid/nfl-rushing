defmodule NflRushingWeb.RushingStatisticsLive do
  @moduledoc false

  use NflRushingWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, rushing_statistics: [], search: nil)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    search = params["search"]
    stats = NflRushing.search_rushing_statistics(search)
    {:noreply, assign(socket, rushing_statistics: stats, search: search)}
  end

  @impl true
  def handle_event("search", %{"q" => name}, socket) do
    {:noreply,
     push_redirect(socket, to: Routes.rushing_statistics_path(socket, :index, search: name))}
  end
end
