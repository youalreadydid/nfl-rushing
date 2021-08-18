defmodule NflRushingTest do
  use NflRushing.DataCase

  describe "search_rushing_statistics/1" do
    test "finds no rushing statistics" do
      assert NflRushing.search_rushing_statistics("john") == []
    end

    test "finds all rushing statistics" do
      stat_one = insert!(:rushing_statistics, %{name: "John Stone"})
      stat_two = insert!(:rushing_statistics, %{name: "Max Smith"})
      assert NflRushing.search_rushing_statistics("") == [stat_one, stat_two]
    end

    test "finds only rushing statistics by players' name" do
      stat_one = insert!(:rushing_statistics, %{name: "John Stone"})
      _stat_two = insert!(:rushing_statistics, %{name: "Max Smith"})
      assert NflRushing.search_rushing_statistics("john") == [stat_one]
    end
  end

  describe "search_rushing_statistics/2" do
    test "finds no rushing statistics" do
      assert NflRushing.search_rushing_statistics("john", []) ==
               []
    end

    test "finds all rushing statistics" do
      stat_one = insert!(:rushing_statistics, %{name: "John Stone"})
      stat_two = insert!(:rushing_statistics, %{name: "Max Smith"})
      assert NflRushing.search_rushing_statistics("", []) == [stat_one, stat_two]
    end

    test "finds only rushing statistics by players' name" do
      stat_one = insert!(:rushing_statistics, %{name: "John Stone"})
      stat_two = insert!(:rushing_statistics, %{name: "John Stone"})
      _stat_three = insert!(:rushing_statistics, %{name: "Max Smith"})

      assert NflRushing.search_rushing_statistics("john", []) == [stat_one, stat_two]
    end

    test "sorts rushing statistics by longest rush" do
      stat_big = insert!(:rushing_statistics, %{longest_rush: 19, longest_rush_touchdown: true})

      stat_medium =
        insert!(:rushing_statistics, %{longest_rush: 19, longest_rush_touchdown: false})

      stat_small = insert!(:rushing_statistics, %{longest_rush: 2})

      assert NflRushing.search_rushing_statistics("", sort: :longest_rush, order: :asc) == [
               stat_small,
               stat_medium,
               stat_big
             ]

      assert NflRushing.search_rushing_statistics("", sort: :longest_rush, order: :desc) == [
               stat_big,
               stat_medium,
               stat_small
             ]
    end

    test "sorts rushing statistics by total touchdowns" do
      stat_big = insert!(:rushing_statistics, %{total_touchdowns: 10})
      stat_small = insert!(:rushing_statistics, %{total_touchdowns: 2})

      assert NflRushing.search_rushing_statistics("", sort: :total_touchdowns, order: :asc) == [
               stat_small,
               stat_big
             ]

      assert NflRushing.search_rushing_statistics("", sort: :total_touchdowns, order: :desc) == [
               stat_big,
               stat_small
             ]
    end

    test "sorts rushing statistics by total yards" do
      stat_big = insert!(:rushing_statistics, %{total_yards: 123})
      stat_small = insert!(:rushing_statistics, %{total_yards: 33})

      assert NflRushing.search_rushing_statistics("", sort: :total_yards, order: :asc) == [
               stat_small,
               stat_big
             ]

      assert NflRushing.search_rushing_statistics("", sort: :total_yards, order: :desc) == [
               stat_big,
               stat_small
             ]
    end
  end

  describe "stream_rushing_statistics/4" do
    test "finds no rushing statistics" do
      fun = fn stream -> assert Enum.to_list(stream) == [] end
      assert NflRushing.stream_rushing_statistics("", nil, nil, fun) == {:ok, true}
    end

    test "finds all rushing statistics" do
      stat_one = insert!(:rushing_statistics, %{name: "John Stone"})
      stat_two = insert!(:rushing_statistics, %{name: "Max Smith"})
      fun = fn stream -> assert Enum.to_list(stream) == [stat_one, stat_two] end
      assert NflRushing.stream_rushing_statistics("", nil, nil, fun) == {:ok, true}
    end

    test "finds only rushing statistics by players' name" do
      stat_one = insert!(:rushing_statistics, %{name: "John Stone"})
      stat_two = insert!(:rushing_statistics, %{name: "John Stone"})
      _stat_three = insert!(:rushing_statistics, %{name: "Max Smith"})

      fun = fn stream -> assert Enum.to_list(stream) == [stat_one, stat_two] end
      assert NflRushing.stream_rushing_statistics("john", nil, nil, fun) == {:ok, true}
    end

    test "sorts rushing statistics by longest rush" do
      stat_big = insert!(:rushing_statistics, %{longest_rush: 19, longest_rush_touchdown: true})

      stat_medium =
        insert!(:rushing_statistics, %{longest_rush: 19, longest_rush_touchdown: false})

      stat_small = insert!(:rushing_statistics, %{longest_rush: 2})

      fun = fn stream ->
        assert Enum.to_list(stream) == [
                 stat_small,
                 stat_medium,
                 stat_big
               ]
      end

      assert NflRushing.stream_rushing_statistics("", :longest_rush, :asc, fun) == {:ok, true}

      fun = fn stream ->
        assert Enum.to_list(stream) == [
                 stat_big,
                 stat_medium,
                 stat_small
               ]
      end

      assert NflRushing.stream_rushing_statistics("", :longest_rush, :desc, fun) == {:ok, true}
    end

    test "sorts rushing statistics by total touchdowns" do
      stat_big = insert!(:rushing_statistics, %{total_touchdowns: 10})
      stat_small = insert!(:rushing_statistics, %{total_touchdowns: 2})

      fun = fn stream ->
        assert Enum.to_list(stream) == [
                 stat_small,
                 stat_big
               ]
      end

      assert NflRushing.stream_rushing_statistics("", :total_touchdowns, :asc, fun) == {:ok, true}

      fun = fn stream ->
        assert Enum.to_list(stream) == [
                 stat_big,
                 stat_small
               ]
      end

      assert NflRushing.stream_rushing_statistics("", :total_touchdowns, :desc, fun) ==
               {:ok, true}
    end

    test "sorts rushing statistics by total yards" do
      stat_big = insert!(:rushing_statistics, %{total_yards: 123})
      stat_small = insert!(:rushing_statistics, %{total_yards: 33})

      fun = fn stream ->
        assert Enum.to_list(stream) == [
                 stat_small,
                 stat_big
               ]
      end

      assert NflRushing.stream_rushing_statistics("", :total_yards, :asc, fun) == {:ok, true}

      fun = fn stream ->
        assert Enum.to_list(stream) == [
                 stat_big,
                 stat_small
               ]
      end

      assert NflRushing.stream_rushing_statistics("", :total_yards, :desc, fun) == {:ok, true}
    end
  end

  describe "list_aggregated_rushing_statistics_by_team/0" do
    test "finds no rushing statistics" do
      assert NflRushing.list_aggregated_rushing_statistics_by_team() == []
    end

    test "finds rushing statistics by team" do
      _stat_one =
        insert!(:rushing_statistics, %{
          name: "John Stone",
          team: "NYG",
          total_yards: 100,
          longest_rush: 10
        })

      _stat_two =
        insert!(:rushing_statistics, %{
          name: "Max Smith",
          team: "NYG",
          total_yards: 50,
          longest_rush: 4
        })

      _stat_three =
        insert!(:rushing_statistics, %{
          name: "John Stone",
          team: "ANO",
          total_yards: 200,
          longest_rush: 5
        })

      _stat_four =
        insert!(:rushing_statistics, %{
          name: "Max Smith",
          team: "ANO",
          total_yards: 100,
          longest_rush: 11
        })

      assert NflRushing.list_aggregated_rushing_statistics_by_team() == [
               %{team: "ANO", total_yards: 300, longest_rush: 11},
               %{team: "NYG", total_yards: 150, longest_rush: 10}
             ]
    end
  end
end
