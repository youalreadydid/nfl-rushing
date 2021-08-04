defmodule ImportRushingStatisticsData do
  @moduledoc false
  alias NflRushing.{Repo, RushingStatistics}

  @path "#{File.cwd!()}/rushing.json"

  @fields ~w(name team position attemps attemps_per_game_average total_yards
             average_yards_per_attempt yards_per_game total_touchdowns longest_rush
             first_downs first_down_percentage yards_each_20_plus yards_each_40_plus
             fumbles)a

  def run(path \\ @path) do
    path
    |> File.stream!()
    |> Jaxon.Stream.from_enumerable()
    |> Jaxon.Stream.query(Jaxon.Path.parse!("$.*"))
    |> Stream.map(&insert_rushing_statistics/1)
    |> Stream.run()
  end

  defp insert_rushing_statistics(stat) do
    {total_yards, _} = stat["Yds"] |> to_string() |> Integer.parse()
    longest_rush = to_string(stat["Lng"])

    attrs = %{
      name: stat["Player"],
      team: stat["Team"],
      position: stat["Pos"],
      attemps: stat["Att"],
      attemps_per_game_average: stat["Att/G"],
      total_yards: total_yards,
      average_yards_per_attempt: stat["Avg"],
      yards_per_game: stat["Yds/G"],
      total_touchdowns: stat["TD"],
      longest_rush: longest_rush,
      first_downs: stat["1st"],
      first_down_percentage: stat["1st%"],
      yards_each_20_plus: stat["20+"],
      yards_each_40_plus: stat["40+"],
      fumbles: stat["FUM"]
    }

    %RushingStatistics{}
    |> Ecto.Changeset.cast(attrs, @fields)
    |> Repo.insert!()
  end
end

ImportRushingStatisticsData.run()
