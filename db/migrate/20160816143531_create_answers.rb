class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.references :users, index: true
      t.references :questions, index: true
      t.references :option_answers, index: true

      t.timestamps
    end
  end
end
