class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.string :desc
      t.integer :user
      t.datetime :date

      t.timestamps
    end
  end
end
