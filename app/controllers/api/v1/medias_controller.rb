class Api::V1::MediasController < ApplicationController
  def index
    attrs = {day: params[:day].to_i, month: params[:month].to_i, year: params[:year].to_i}
    calendar_day = CalendarDay.where(attrs).first
    if calendar_day 
      @media = Medium.where(liturgic_day_id: calendar_day.liturgic_day_id)
      Rails.logger.info "#{@media.length} media for #{attrs}"
    end
    render json: @media || []
  end
end
