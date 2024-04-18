namespace :import do
  desc "Import media for a date"
  task media: :environment do
    start_date = Date.parse(ENV['start_date'])
    end_date = Date.parse(ENV['end_date'])
    Medium.sync(start_date, end_date)
  end

end
