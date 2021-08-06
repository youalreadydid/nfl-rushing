defmodule NflRushingWeb.RushingStatisticsControllerTest do
  use NflRushingWeb.ConnCase
  import Mock
  alias NimbleCSV.RFC4180, as: CSV

  describe "csv/2" do
    @header CSV.dump_to_iodata([
              ~w(Player Team Pos Att Att/G Yds Avg Yds/G TD Lng 1st 1st% 20+ 40+ FUM)
            ])

    test "sends csv with no rushing statistics", %{conn: conn} do
      pid = self()

      with_mock Plug.Conn, [:passthrough], chunk: chunk_mock(pid) do
        conn = get(conn, Routes.rushing_statistics_path(conn, :csv))
        assert response(conn, 200)
        assert_receive @header
        assert_received_all_chunks()
      end
    end

    test "sends csv with all rushing statistics", %{conn: conn} do
      first_rows = 1..200 |> Enum.map(fn _ -> insert!(:rushing_statistics) end) |> csv_rows()
      last_rows = 1..150 |> Enum.map(fn _ -> insert!(:rushing_statistics) end) |> csv_rows()

      pid = self()

      with_mock Plug.Conn, [:passthrough], chunk: chunk_mock(pid) do
        conn = get(conn, Routes.rushing_statistics_path(conn, :csv, sort: "total_yards"))
        assert response(conn, 200)
        assert_receive @header
        assert_receive ^first_rows
        assert_receive ^last_rows
        assert_received_all_chunks()
      end
    end

    test "sends csv with all filtered rushing statistics", %{conn: conn} do
      _ignored_stat = insert!(:rushing_statistics, %{name: "John Steel"})
      attrs = %{name: "Max Smith"}
      rows = csv_rows([insert!(:rushing_statistics, attrs), insert!(:rushing_statistics, attrs)])

      pid = self()

      with_mock Plug.Conn, [:passthrough], chunk: chunk_mock(pid) do
        conn = get(conn, Routes.rushing_statistics_path(conn, :csv, search: "Max Smith"))
        assert response(conn, 200)
        assert_receive @header
        assert_receive ^rows
        assert_received_all_chunks()
      end
    end

    test "sends csv with all sorted rushing statistics", %{conn: conn} do
      first_rows =
        1..200 |> Enum.map(&insert!(:rushing_statistics, %{total_yards: &1})) |> csv_rows()

      last_rows =
        1..150 |> Enum.map(&insert!(:rushing_statistics, %{total_yards: 200 + &1})) |> csv_rows()

      pid = self()

      with_mock Plug.Conn, [:passthrough], chunk: chunk_mock(pid) do
        conn =
          get(conn, Routes.rushing_statistics_path(conn, :csv, sort: "total_yards", order: "asc"))

        assert response(conn, 200)
        assert_receive @header
        assert_receive ^first_rows
        assert_receive ^last_rows
        assert_received_all_chunks()
      end
    end

    test "sends csv with all filtered and sorted rushing statistics", %{conn: conn} do
      _ignored_stat = insert!(:rushing_statistics, %{name: "John Steel"})

      rows =
        csv_rows([
          insert!(:rushing_statistics, %{name: "Max Smith", total_touchdowns: 2}),
          insert!(:rushing_statistics, %{name: "Max Smith", total_touchdowns: 1})
        ])

      pid = self()

      with_mock Plug.Conn, [:passthrough], chunk: chunk_mock(pid) do
        params = [search: "max", sort: "total_touchdowns", order: "desc"]
        conn = get(conn, Routes.rushing_statistics_path(conn, :csv, params))

        assert response(conn, 200)
        assert_receive @header
        assert_receive ^rows
        assert_received_all_chunks()
      end
    end

    defp csv_rows(stats) do
      NflRushingWeb.RushingStatisticsView
      |> Phoenix.View.render("index.csv", rushing_statistics: stats)
      |> CSV.dump_to_iodata()
    end

    # idea: https://github.com/Nagasaki45/watercooler-2/blob/master/test/water_cooler_test.exs#L26
    defp chunk_mock(pid), do: fn _conn, chunk -> send(pid, chunk) end

    defp assert_received_all_chunks do
      assert_receive({:plug_conn, :sent})
      refute_receive(_)
    end
  end
end
