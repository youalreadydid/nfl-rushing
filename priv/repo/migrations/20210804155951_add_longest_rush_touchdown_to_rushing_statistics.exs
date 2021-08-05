defmodule NflRushing.Repo.Migrations.AddLongestRushTouchdownToRushingStatistics do
  use Ecto.Migration

  def change do
    alter table(:rushing_statistics) do
      add :longest_rush, :integer
      add :longest_rush_touchdown, :boolean
    end

    create index(:rushing_statistics, [:longest_rush])
    create index(:rushing_statistics, [:longest_rush_touchdown])
  end
end
