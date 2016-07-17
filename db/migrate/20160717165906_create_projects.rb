class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :external_id
      t.string :slug
      t.string :scm_service
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
