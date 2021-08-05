defmodule NflRushing.Repo.Migrations.RemoveLongestRushFromRushingStatistics do
  use Ecto.Migration

  def change do
    alter table(:rushing_statistics) do
      remove :longest_rush, :string
    end
  end
end
