# frozen_string_literal: true

class CreateLessonTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :lesson_topics do |t|
      t.references :topics
      t.references :lesson

      t.timestamps
    end
  end
end
