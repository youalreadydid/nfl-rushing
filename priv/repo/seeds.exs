# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NflRushing.Repo.insert!(%NflRushing.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

NflRushing.Repo.delete_all(NflRushing.RushingStatistics)
Code.eval_file("#{File.cwd!()}/priv/scripts/01_import_rushing_data.exs")
ImportRushingStatisticsData.run()
