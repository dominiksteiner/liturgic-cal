class Celebration < ApplicationRecord
  belongs_to :liturgic_day

  def self.get_or_create(celebration_info, liturgic_day_id)
    attrs = celebration_info.merge({liturgic_day_id: liturgic_day_id})
    celebration = Celebration.where(attrs).first
    unless celebration
      celebration = Celebration.create!(attrs)
      Rails.logger.info "created Celebration : #{attrs}"
    end
    celebration
  end

end
