defmodule NflRushingWeb.StatisticsHeaderComponent do
  @moduledoc false

  use NflRushingWeb, :live_component

  def render(assigns) do
    ~L"""
      <tr>
        <th>Player</th>
        <th>Team</th>
        <th>Pos</th>
        <th>Att</th>
        <th>Att/G</th>
        <th><%= render_sorted_column(assigns, "Yds", :total_yards) %></th>
        <th>Avg</th>
        <th>Yds/G</th>
        <th><%= render_sorted_column(assigns, "TD", :total_touchdowns) %></th>
        <th><%= render_sorted_column(assigns, "Lng", :longest_rush) %></th>
        <th>1st</th>
        <th>1st%</th>
        <th>20+</th>
        <th>40+</th>
        <th>FUM</th>
      </tr>
    """
  end

  defp render_sorted_column(
         %{sort: sort, order: order, search: search, socket: socket},
         name,
         field
       ) do
    next_order =
      if field == sort do
        %{:desc => :asc, :asc => nil, nil => :desc}[order]
      else
        :desc
      end

    next_sort = if is_nil(next_order), do: nil, else: field

    name_with_icon =
      if sort == field do
        sort_icon = %{asc: "↑", desc: "↓", nil: ""}
        name <> sort_icon[order]
      else
        name
      end

    params = %{search: search, sort: next_sort, order: next_order}
    live_patch(name_with_icon, to: Routes.rushing_statistics_path(socket, :index, params))
  end
end
