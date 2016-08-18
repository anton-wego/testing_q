class Quiz < ApplicationRecord
  validates :question, :answer, presence: true

  def self.get_answer(quiz_id, user_answer)
    result = 'INCORRECT'

    rec = self.where(["id = ?", quiz_id]).first
    return result if rec.blank?

    if rec.answer == user_answer
      result = 'CORRECT'
    end

    if is_number?(rec.answer) && (rec.answer.to_i.to_words remove_hyphen: true).to_s.downcase == user_answer.to_s.downcase
      result = 'CORRECT'
    end

    if is_number?(user_answer) && (user_answer.to_i.to_words remove_hyphen: true).to_s.downcase == rec.answer.to_s.downcase
      result = 'CORRECT'
    end

    result
  end

  protected
  def self.is_number?(input)
    true if Float(input) rescue false
  end
end
