defmodule NflRushingWeb.StatisticsComponent do
  @moduledoc false

  use NflRushingWeb, :live_component

  def render(assigns) do
    ~L"""
    <table style="width:100%">
      <tr>
        <th>Player</th>
        <th>Team</th>
        <th>Pos</th>
        <th>Att/G</th>
        <th>Att</th>
        <th>Yds</th>
        <th>Avg</th>
        <th>Yds/G</th>
        <th>TD</th>
        <th>Lng</th>
        <th>1st</th>
        <th>1st%</th>
        <th>20+</th>
        <th>40+</th>
        <th>FUM</th>
      </tr>
      <%= render_statistics_rows(assigns, @rushing_statistics) %>
    </table>
    """
  end

  defp render_statistics_rows(assigns, statistics) do
    if statistics == [] do
      ~L"<tr></tr>"
    else
      ~L"""
      <%= for stat <- statistics do %>
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
      <% end %>
      """
    end
  end
end
