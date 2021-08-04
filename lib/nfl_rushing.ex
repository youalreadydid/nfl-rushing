defmodule NflRushing do
  @moduledoc false

  alias NflRushing.{Repo, RushingStatistics}

  @spec list_rushing_statistics :: list(RushingStatistics.t())
  def list_rushing_statistics, do: Repo.all(RushingStatistics)
end
