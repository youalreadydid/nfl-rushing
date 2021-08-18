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
    |> rushing_statistics_query(search_name, sort, order)
    |> Repo.all()
  end

  defp rushing_statistics_query(query, name, sort, order) do
    query
    |> where([s], like(s.name, ^name))
    |> order_rushing_statistics_by(sort, order)
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

  @spec stream_rushing_statistics(String.t(), atom(), atom(), function()) ::
          {:ok, any()} | {:error, any()}
  def stream_rushing_statistics(name, sort, order, callback) do
    search_name = "%#{name}%"

    Repo.transaction(fn ->
      query = rushing_statistics_query(RushingStatistics, search_name, sort, order)
      stream = Repo.stream(query)
      callback.(stream)
    end)
  end

  @spec list_aggregated_rushing_statistics_by_team() :: list(map())
  def list_aggregated_rushing_statistics_by_team do
    RushingStatistics
    |> group_by([rs], rs.team)
    |> select([rs], %{
      team: rs.team,
      total_yards: sum(rs.total_yards),
      longest_rush: max(rs.longest_rush)
    })
    |> Repo.all()
  end
end
