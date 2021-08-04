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
end
