class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.integer :charge

      t.references :gym-id, foreign_key: true
      t.references :client-id, foreign_key: true

      t.timestamps
    end
  end
end
