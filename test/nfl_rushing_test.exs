defmodule NflRushingTest do
  use NflRushing.DataCase

  describe "list_rushing_statistics/0" do
    test "finds no rushing statistics" do
      assert NflRushing.list_rushing_statistics() == []
    end

    test "finds all rushing statistics" do
      stat_one = insert!(:rushing_statistics)
      stat_two = insert!(:rushing_statistics)
      assert NflRushing.list_rushing_statistics() == [stat_one, stat_two]
    end
  end
end
