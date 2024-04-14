namespace :import do
  desc "Import media for a date"
  task media: :environment do
    start_date = Date.parse(ENV['start_date'])
    end_date = Date.parse(ENV['end_date'])
    start_date.upto(end_date) do |date|
      Medium.sync(date)
    end
  end

end
