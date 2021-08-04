defmodule NflRushing do
  @moduledoc false
  import Ecto.Query

  alias NflRushing.{Repo, RushingStatistics}

  @spec search_rushing_statistics(String.t()) :: list(RushingStatistics.t())
  def search_rushing_statistics(player_name \\ "%") do
    search_name = "%#{player_name}%"

    RushingStatistics
    |> where([s], like(s.name, ^search_name))
    |> Repo.all()
  end
end
