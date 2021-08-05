defmodule NflRushingWeb.RushingStatisticsLive do
  @moduledoc false
  use NflRushingWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, rushing_statistics: [], search: nil, sort: nil, order: nil)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {search, sort, order} = parse_params(params)
    stats = NflRushing.search_rushing_statistics(search, sort: sort, order: order)

    params = [rushing_statistics: stats, search: search, sort: sort, order: order]
    {:noreply, assign(socket, params)}
  end

  @sort_fields ~w(total_yards longest_rush total_touchdowns)
  defp parse_params(params) do
    search = params["search"] || ""
    sort = if to_string(params["sort"]) in @sort_fields, do: String.to_atom(params["sort"])
    order = if to_string(params["order"]) == "desc", do: :desc, else: :asc
    {search, sort, order}
  end

  @impl true
  def handle_event("search", %{"q" => name}, %{assigns: assigns} = socket) do
    {:noreply,
     push_redirect(socket,
       to:
         Routes.rushing_statistics_path(socket, :index,
           search: name,
           sort: assigns.sort,
           order: assigns.order
         )
     )}
  end
end
