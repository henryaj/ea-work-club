class DropImpressionsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :impressions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
