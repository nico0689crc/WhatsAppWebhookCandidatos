class CreateCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :contact_email, null: false
      t.string :contact_whatsapp, null: false
      t.string :contact_linked_in
      t.timestamps
    end
  end
end
