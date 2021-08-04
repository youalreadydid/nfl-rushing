defmodule NflRushingWeb.StatisticsComponentTest do
  use NflRushingWeb.ConnCase
  import Phoenix.LiveViewTest

  alias NflRushingWeb.StatisticsComponent

  test "renders no statistics" do
    assert render_component(StatisticsComponent, rushing_statistics: []) =~
             "<tr></tr>"
  end

  test "renders some rushing statistics" do
    stat_one = build(:rushing_statistics)
    stat_two = build(:rushing_statistics, %{name: "Max Smith", longest_rush_touchdown: true})
    stats = [stat_one, stat_two]

    rendered_component = render_component(StatisticsComponent, rushing_statistics: stats)

    for stat <- stats do
      ltd = if stat.longest_rush_touchdown, do: "T"

      assert rendered_component =~
               """
                   <td>#{stat.name}</td>
                   <td>#{stat.team}</td>
                   <td>#{stat.position}</td>
                   <td>#{stat.attemps}</td>
                   <td>#{stat.attemps_per_game_average}</td>
                   <td>#{stat.total_yards}</td>
                   <td>#{stat.average_yards_per_attempt}</td>
                   <td>#{stat.yards_per_game}</td>
                   <td>#{stat.total_touchdowns}</td>
                   <td>#{stat.longest_rush}#{ltd}</td>
                   <td>#{stat.first_downs}</td>
                   <td>#{stat.first_down_percentage}</td>
                   <td>#{stat.yards_each_20_plus}</td>
                   <td>#{stat.yards_each_40_plus}</td>
                   <td>#{stat.fumbles}</td>
               """
    end
  end
end
