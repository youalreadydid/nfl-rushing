defmodule NflRushing.Fixtures do
  @moduledoc false

  alias NflRushing.Repo

  @spec build(atom) :: struct
  def build(schema)

  def build(:rushing_statistics) do
    %NflRushing.RushingStatistics{
      name: "Shane Vereen",
      team: "NYG",
      position: "RB",
      attemps: 33,
      attemps_per_game_average: 6.6,
      total_yards: 158,
      average_yards_per_attempt: 4.8,
      yards_per_game: 31.6,
      total_touchdowns: 1,
      longest_rush: 25,
      longest_rush_touchdown: false,
      first_downs: 8,
      first_down_percentage: 24.2,
      yards_each_20_plus: 1,
      yards_each_40_plus: 0,
      fumbles: 1
    }
  end

  @spec build(atom, map | keyword) :: struct
  def build(schema, attrs), do: schema |> build() |> struct(attrs)

  @spec insert!(atom, map) :: struct
  def insert!(schema, attrs \\ %{}),
    do: schema |> build(attrs) |> Repo.insert!(on_conflict: :nothing)
end
