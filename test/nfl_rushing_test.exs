defmodule NflRushingTest do
  use NflRushing.DataCase

  describe "list_rushing_statistics/0" do
    test "finds no rushing statistics" do
      assert NflRushing.list_rushing_statistics() == []
    end
  end
end
