class RenameTopicsIdInLessonTopics < ActiveRecord::Migration[8.0]
  def change
    rename_column :lesson_topics, :topics_id, :topic_id
  end
end
