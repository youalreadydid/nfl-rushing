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
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
    </table>
    """
  end
end
