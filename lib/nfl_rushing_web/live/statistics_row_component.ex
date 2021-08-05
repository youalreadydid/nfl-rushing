defmodule NflRushingWeb.StatisticsRowComponent do
  @moduledoc false

  use NflRushingWeb, :live_component

  def render(assigns) do
    stat = assigns.rushing_statistics

    ~L"""
      <% ltd = if stat.longest_rush_touchdown, do: "T" %>
      <% longest_rush = "#{stat.longest_rush}#{ltd}" %>

      <tr>
        <td><%= stat.name %></td>
        <td><%= stat.team %></td>
        <td><%= stat.position %></td>
        <td><%= stat.attemps %></td>
        <td><%= stat.attemps_per_game_average %></td>
        <td><%= stat.total_yards %></td>
        <td><%= stat.average_yards_per_attempt %></td>
        <td><%= stat.yards_per_game %></td>
        <td><%= stat.total_touchdowns %></td>
        <td><%= longest_rush %></td>
        <td><%= stat.first_downs %></td>
        <td><%= stat.first_down_percentage %></td>
        <td><%= stat.yards_each_20_plus %></td>
        <td><%= stat.yards_each_40_plus %></td>
        <td><%= stat.fumbles %></td>
      </tr>
    """
  end
end
