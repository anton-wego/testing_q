class CreateOptionAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :option_answers do |t|
      t.references :question, index: true
      t.boolean :is_correct, default: false
      t.text :content

      t.timestamps
    end
  end
end
