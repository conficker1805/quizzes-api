class BootstrapDatabase < ActiveRecord::Migration[7.0]
  def up
    enable_extension 'hstore'

    create_table :domains do |t|
      t.string :name, null: false
      t.string :slug, index: true, unique: true

      t.timestamps null: false
    end

    create_table :quizzes do |t|
      t.references :domain, null: false, index: true
      t.string :kind, null: false, index: true
      t.string :state, default: :active, null: false, index: true
      t.text :content

      t.timestamps null: false
    end

    create_table :answers do |t|
      t.references :quiz, null: false, index: true
      t.string :active, default: :active, null: false, index: true
      t.boolean :correct, default: false, null: false
      t.text :content

      t.timestamps null: false
    end

    create_table :users_answers do |t|
      t.references :user, null: false, index: true
      t.references :domain, null: false, index: true
      t.hstore :expectation, default: {}, null: false
      t.hstore :detail, default: {}, null: false
      t.string :state, default: :processing, null: false, index: true

      t.timestamps null: false
    end
  end

  def down
    drop_table :users_answers
    drop_table :answers
    drop_table :quizzes
    drop_table :domains

    disable_extension 'hstore'
  end
end
