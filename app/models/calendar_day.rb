class CalendarDay < ApplicationRecord
  belongs_to :liturgic_day

  def self.get_or_create(date, liturgic_day_id)
    attrs = {day: date.day, month: date.month, year: date.year, liturgic_day_id: liturgic_day_id}
    calendar_day = CalendarDay.where(attrs).first
    unless calendar_day
      calendar_day = CalendarDay.create!(attrs)
      Rails.logger.info "created CalendarDay : #{attrs}"
    end
    calendar_day
  end
end
