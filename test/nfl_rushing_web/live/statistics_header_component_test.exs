defmodule NflRushingWeb.StatisticsHeaderComponentTest do
  use NflRushingWeb.ConnCase
  import Phoenix.LiveViewTest

  alias NflRushingWeb.StatisticsHeaderComponent

  test "renders a header" do
    assert render_component(StatisticsHeaderComponent, search: "joe", sort: nil, order: nil) =~
             """
                 <th>Player</th>
                 <th>Team</th>
                 <th>Pos</th>
                 <th>Att/G</th>
                 <th>Att</th>
                 <th><a data-phx-link=\"patch\" data-phx-link-state=\"push\" href=\"/?order=desc&amp;search=joe&amp;sort=total_yards\">Yds</a></th>
                 <th>Avg</th>
                 <th>Yds/G</th>
                 <th><a data-phx-link=\"patch\" data-phx-link-state=\"push\" href=\"/?order=desc&amp;search=joe&amp;sort=total_touchdowns\">TD</a></th>
                 <th><a data-phx-link=\"patch\" data-phx-link-state=\"push\" href=\"/?order=desc&amp;search=joe&amp;sort=longest_rush\">Lng</a></th>
                 <th>1st</th>
                 <th>1st%</th>
                 <th>20+</th>
                 <th>40+</th>
                 <th>FUM</th>
             """
  end

  test "renders a header with existing desc order" do
    assert render_component(StatisticsHeaderComponent,
             search: "joe",
             sort: :total_yards,
             order: :desc
           ) =~
             """
                 <th>Player</th>
                 <th>Team</th>
                 <th>Pos</th>
                 <th>Att/G</th>
                 <th>Att</th>
                 <th><a data-phx-link=\"patch\" data-phx-link-state=\"push\" href=\"/?order=asc&amp;search=joe&amp;sort=total_yards\">Yds↓</a></th>
                 <th>Avg</th>
                 <th>Yds/G</th>
                 <th><a data-phx-link=\"patch\" data-phx-link-state=\"push\" href=\"/?order=desc&amp;search=joe&amp;sort=total_touchdowns\">TD</a></th>
                 <th><a data-phx-link=\"patch\" data-phx-link-state=\"push\" href=\"/?order=desc&amp;search=joe&amp;sort=longest_rush\">Lng</a></th>
                 <th>1st</th>
                 <th>1st%</th>
                 <th>20+</th>
                 <th>40+</th>
                 <th>FUM</th>
             """
  end

  test "renders a header with existing asc order" do
    assert render_component(StatisticsHeaderComponent,
             search: "joe",
             sort: :total_yards,
             order: :asc
           ) =~
             """
                 <th>Player</th>
                 <th>Team</th>
                 <th>Pos</th>
                 <th>Att/G</th>
                 <th>Att</th>
                 <th><a data-phx-link=\"patch\" data-phx-link-state=\"push\" href=\"/?order=&amp;search=joe&amp;sort=\">Yds↑</a></th>
                 <th>Avg</th>
                 <th>Yds/G</th>
                 <th><a data-phx-link=\"patch\" data-phx-link-state=\"push\" href=\"/?order=desc&amp;search=joe&amp;sort=total_touchdowns\">TD</a></th>
                 <th><a data-phx-link=\"patch\" data-phx-link-state=\"push\" href=\"/?order=desc&amp;search=joe&amp;sort=longest_rush\">Lng</a></th>
                 <th>1st</th>
                 <th>1st%</th>
                 <th>20+</th>
                 <th>40+</th>
                 <th>FUM</th>
             """
  end
end
