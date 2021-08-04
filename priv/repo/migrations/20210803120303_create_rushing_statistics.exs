defmodule NflRushing.Repo.Migrations.CreateRushingStatistics do
  use Ecto.Migration

  def change do
    create table(:rushing_statistics, primary_key: false) do
      add :name, :string
      add :team, :string
      add :position, :string
      add :attemps, :integer
      add :attemps_per_game_average, :float
      add :total_yards, :integer
      add :average_yards_per_attempt, :float
      add :yards_per_game, :float
      add :total_touchdowns, :integer
      add :longest_rush, :string
      add :first_downs, :integer
      add :first_down_percentage, :float
      add :yards_each_20_plus, :integer
      add :yards_each_40_plus, :integer
      add :fumbles, :integer
    end
  end
end
