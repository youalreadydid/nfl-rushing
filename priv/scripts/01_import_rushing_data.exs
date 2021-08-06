defmodule ImportRushingStatisticsData do
  @moduledoc false
  alias NflRushing.{Repo, RushingStatistics}

  @path "#{File.cwd!()}/rushing.json"

  def run(path \\ @path) do
    path
    |> File.stream!()
    |> Jaxon.Stream.from_enumerable()
    |> Jaxon.Stream.query(Jaxon.Path.parse!("$.*"))
    |> Stream.map(&insert_rushing_statistics/1)
    |> Stream.run()
  end

  defp insert_rushing_statistics(stat) do
    total_yards = parse_total_yards(stat)
    {longest_rush, longest_rush_touchdown} = parse_longest_rush(stat)

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
      longest_rush_touchdown: longest_rush_touchdown,
      first_downs: stat["1st"],
      first_down_percentage: stat["1st%"],
      yards_each_20_plus: stat["20+"],
      yards_each_40_plus: stat["40+"],
      fumbles: stat["FUM"]
    }

    fields = Map.keys(attrs)

    %RushingStatistics{}
    |> Ecto.Changeset.cast(attrs, fields)
    |> Repo.insert!()
  end

  defp parse_total_yards(stat) do
    {total_yards, ""} =
      stat["Yds"] |> to_string() |> String.replace(~r/[^\d|\.|\-]/, "") |> Integer.parse()

    total_yards
  end

  defp parse_longest_rush(stat) do
    if is_integer(stat["Lng"]) do
      {stat["Lng"], false}
    else
      {longest_rush, touchdown} = Integer.parse(stat["Lng"])
      {longest_rush, touchdown == "T"}
    end
  end
end
