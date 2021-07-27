class AddIntroductionToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :introduction, :text
  end
end
