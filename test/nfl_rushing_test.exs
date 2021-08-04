defmodule NflRushingTest do
  use NflRushing.DataCase

  describe "search_rushing_statistics/0" do
    test "finds no rushing statistics" do
      assert NflRushing.search_rushing_statistics() == []
    end

    test "finds all rushing statistics" do
      stat_one = insert!(:rushing_statistics)
      stat_two = insert!(:rushing_statistics)
      assert NflRushing.search_rushing_statistics() == [stat_one, stat_two]
    end
  end

  describe "search_rushing_statistics/1" do
    test "finds no rushing statistics" do
      assert NflRushing.search_rushing_statistics("john") == []
    end

    test "finds all rushing statistics" do
      stat_one = insert!(:rushing_statistics, %{name: "John Stone"})
      _stat_two = insert!(:rushing_statistics, %{name: "Max Smith"})
      assert NflRushing.search_rushing_statistics("john") == [stat_one]
    end
  end
end
