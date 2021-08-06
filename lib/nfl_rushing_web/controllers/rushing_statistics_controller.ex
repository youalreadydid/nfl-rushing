defmodule NflRushingWeb.RushingStatisticsController do
  use NflRushingWeb, :controller

  alias NflRushingWeb.RushingStatisticsView
  alias Phoenix.View

  @sorts ~w(total_yards longest_rush total_touchdowns)
  @orders ~w(asc desc)
  @spec csv(Plug.Conn.t(), nil | maybe_improper_list | map) :: Plug.Conn.t()
  def csv(conn, params) do
    search = params["search"]
    sort = if params["sort"] in @sorts, do: String.to_atom(params["sort"])
    order = if params["order"] in @orders, do: String.to_atom(params["order"])

    conn =
      conn
      |> put_resp_content_type("text/csv")
      |> put_resp_header("content-disposition", ~s[attachment; filename="rushing_statistics.csv"])
      |> send_chunked(:ok)

    NflRushing.stream_rushing_statistics(search, sort, order, fn stream ->
      header = ~w(Player Team Pos Att Att/G Yds Avg Yds/G TD Lng 1st 1st% 20+ 40+ FUM)
      row = NimbleCSV.RFC4180.dump_to_iodata([header])
      chunk(conn, row)

      # sqlite cannot stream more than one row each time :(
      stream
      |> Stream.chunk_every(200)
      |> Enum.each(fn rushing_statistics ->
        rows =
          View.render(RushingStatisticsView, "index.csv", rushing_statistics: rushing_statistics)

        csv_rows = NimbleCSV.RFC4180.dump_to_iodata(rows)
        chunk(conn, csv_rows)
      end)
    end)

    conn
  end
end
