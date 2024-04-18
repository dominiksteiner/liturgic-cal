require 'httparty'

class Medium < ApplicationRecord
  belongs_to :liturgic_day

  def self.sync(start_date, end_date)
    yt_info = Medium.get_yt_info(start_date, end_date)
    Rails.logger.info "yt info : #{yt_info["items"].length} : #{yt_info["items"].map { |yt_video| yt_video["snippet"]["title"]}}"

    start_date.upto(end_date) do |date|
      date_str = date.strftime("%Y/%-m/%-d")
      url = "http://calapi.inadiutorium.cz/api/v0/en/calendars/default/#{date_str}"
      response = HTTParty.get(url)
      if response.code != 200 
        error = "could not get liturgic calendar info : #{url} : #{response}"
        Rails.logger.error(error)
        raise error 
      end
      liturgic_info = JSON.parse(response.body)

      liturgic_day = LiturgicDay.get_or_create(liturgic_info)

      calendar_day = CalendarDay.get_or_create(date, liturgic_day.id)

      celebrations = liturgic_info["celebrations"].map do |celebration|
        Celebration.get_or_create(celebration, liturgic_day.id)
      end

      yt_video = yt_info["items"].find do |item| 
        published_at = Date.parse(item["snippet"]["publishedAt"])
        published_at.to_date == date.to_date
      end

      if yt_video
        medium = Medium.get_or_create(yt_video, date, liturgic_day.id)
      else
        Rails.logger.error "could not find yt video info : #{date}"
      end
    end
  end

  def self.get_or_create(yt_video, date, liturgic_day_id)
    medium_attrs = {
      external_id: yt_video["id"]["videoId"], 
      title: yt_video["snippet"]["title"],
      description: yt_video["snippet"]["description"],
      thumbnail_url: yt_video["snippet"]["thumbnails"]["default"]["url"],
      published_at: yt_video["snippet"]["publishedAt"],
      url: "http://www.youtube.com/watch?v=#{yt_video["id"]["videoId"]}",
      liturgic_day_id: liturgic_day_id
    }
    medium = Medium.where({external_id: medium_attrs[:external_id]}).first
    unless medium 
      Medium.create!(medium_attrs)
      Rails.logger.info "created Medium : #{medium_attrs}"
    end
    medium
  end

  def self.get_yt_info(start_date, end_date)
    start_date_str = start_date.beginning_of_day.iso8601
    end_date_str = end_date.end_of_day.iso8601
    params = {
      publishedAfter: start_date_str,
      publishedBefore: end_date_str,
      key: ENV['YT_API_KEY'],
      part: 'snippet',
      maxResults: 50,
      channelId: 'UCLc_sOTchYgGsTCMuXs3Duw',
      q: 'Homilía+Santiago'
    }
    yt_url = "https://www.googleapis.com/youtube/v3/search?#{params.to_query}"
    yt_response = HTTParty.get(yt_url)
    if yt_response.code != 200 
      error = "could not get youtube info : #{yt_url} : #{yt_response}"
      Rails.logger.error(error)
      raise error 
    end
    yt_info = JSON.parse(yt_response.body)
    yt_info
  end
end
