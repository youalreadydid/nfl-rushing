defmodule NflRushingWeb.StatisticsComponentTest do
  use NflRushingWeb.ConnCase
  import Phoenix.LiveViewTest

  alias NflRushingWeb.StatisticsComponent

  test "renders no statistics" do
    assert render_component(StatisticsComponent, rushing_statistics: []) =~
               "<tr>\n    <td></td>\n    <td></td>\n    <td></td>"
  end
end
