defmodule NflRushing.Repo.Migrations.AddIndexToSortableFieldsOnRushingStatistics do
  use Ecto.Migration

  def change do
    create index(:rushing_statistics, [:total_yards])
    create index(:rushing_statistics, [:total_touchdowns])
  end
end
