class CreateCdClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :cd_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end
