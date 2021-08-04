defmodule NflRushing do
  @moduledoc false
  import Ecto.Query

  alias NflRushing.{Repo, RushingStatistics}

  @spec search_rushing_statistics(String.t(), keyword()) :: list(RushingStatistics.t())
  def search_rushing_statistics(player_name, opts \\ []) do
    search_name = "%#{player_name}%"
    sort = Keyword.get(opts, :sort)
    order = Keyword.get(opts, :order)

    RushingStatistics
    |> where([s], like(s.name, ^search_name))
    |> order_rushing_statistics_by(sort, order)
    |> Repo.all()
  end

  defp order_rushing_statistics_by(query, field, order) do
    fields = ~w(total_yards longest_rush total_touchdowns)a
    orders = ~w(asc desc)a

    order_fragment =
      if field == :longest_rush do
        [{order, :longest_rush}, {order, :longest_rush_touchdown}]
      else
        [{order, field}]
      end

    if field in fields and order in orders do
      order_by(query, [s], ^order_fragment)
    else
      query
    end
  end
end
