class LiturgicDay < ApplicationRecord
    def self.get_or_create(liturgic_info)
        liturgic_day_info = liturgic_info.slice(*LiturgicDay.attribute_names)
        liturgic_day = LiturgicDay.where(liturgic_day_info).first
        unless liturgic_day
          liturgic_day = LiturgicDay.create!(liturgic_day_info)
          Rails.logger.info "created LiturgicDay : #{liturgic_day_info}"
        end
        liturgic_day
    end
end
