# frozen_string_literal: true

class LessonTopic < ApplicationRecord
  belongs_to :topic
  belongs_to :lesson
end
