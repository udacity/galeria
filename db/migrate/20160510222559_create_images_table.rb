class CreateImagesTable < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.string :title
      t.string :url
    end
  end

  def down
    drop_table :images
  end
end
