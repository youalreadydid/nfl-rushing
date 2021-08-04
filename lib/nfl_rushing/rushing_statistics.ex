defmodule NflRushing.RushingStatistics do
  @moduledoc """
  Football players' rushing statistics schema.

  Fields:
  * `name` (Player's name)
  * `team` (Player's team abbreviation)
  * `position` (Player's postion)
  * `attemps_per_game_average` (Rushing Attempts Per Game Average)
  * `attemps` (Rushing Attempts)
  * `total_yards` (Total Rushing Yards)
  * `average_yards_per_attempt` (Rushing Average Yards Per Attempt)
  * `yards_per_game` (Rushing Yards Per Game)
  * `total_touchdowns` (Total Rushing Touchdowns)
  * `longest_rush` (Longest Rush -- a `T` represents a touchdown occurred)
  * `first_downs` (Rushing First Downs)
  * `first_down_percentage` (Rushing First Down Percentage)
  * `yards_each_20_plus` (Rushing 20+ Yards Each)
  * `yards_each_40_plus` (Rushing 40+ Yards Each)
  * `fumbles` (Rushing Fumbles)
  """
  use Ecto.Schema

  @type t :: %__MODULE__{
          name: String.t(),
          team: String.t(),
          position: String.t(),
          attemps: integer,
          attemps_per_game_average: float,
          total_yards: integer,
          average_yards_per_attempt: float,
          yards_per_game: float,
          total_touchdowns: integer,
          longest_rush: String.t(),
          first_downs: integer,
          first_down_percentage: float,
          yards_each_20_plus: integer,
          yards_each_40_plus: integer,
          fumbles: integer
        }

  @primary_key false
  schema "rushing_statistics" do
    field :name, :string
    field :team, :string
    field :position, :string
    field :attemps, :integer
    field :attemps_per_game_average, :float
    field :total_yards, :integer
    field :average_yards_per_attempt, :float
    field :yards_per_game, :float
    field :total_touchdowns, :integer
    field :longest_rush, :integer
    field :longest_rush_touchdown, :boolean, default: false
    field :first_downs, :integer
    field :first_down_percentage, :float
    field :yards_each_20_plus, :integer
    field :yards_each_40_plus, :integer
    field :fumbles, :integer
  end
end
