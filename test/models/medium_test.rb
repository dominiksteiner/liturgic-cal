require "test_helper"

class MediumTest < ActiveSupport::TestCase
  test "#sync" do
    date = Date.parse("2024-02-17")
    Medium.sync(date)

    assert_equal 1, LiturgicDay.count
    liturgic_day = LiturgicDay.first 
    assert_equal("lent", liturgic_day.season)
    assert_equal("0", liturgic_day.season_week)
    assert_equal("saturday", liturgic_day.weekday)

    assert_equal 1, CalendarDay.count
    calendar_day = CalendarDay.first 
    assert_equal(17, calendar_day.day)
    assert_equal(2, calendar_day.month)
    assert_equal(2024, calendar_day.year)

    assert_equal 2, Celebration.count
    celebration_1 = Celebration.first 
    celebration_2 = Celebration.last 
    assert_equal("Saturday after Ash Wednesday", celebration_1.title)
    assert_equal("Seven Holy Founders of the Servite Order", celebration_2.title)
    assert_equal("violet", celebration_1.colour)
    assert_equal("violet", celebration_2.colour)
    assert_equal("ferial", celebration_1.rank)
    assert_equal("commemoration", celebration_2.rank)
    assert_equal("2.9", celebration_1.rank_num)
    assert_equal("4.0", celebration_2.rank_num)

    assert_equal 1, Medium.count
    medium = Medium.first 
    assert_equal('http://www.youtube.com/watch?v=B78f1dXM4tU', medium.url)
    assert_equal('B78f1dXM4tU', medium.external_id)
    assert_equal('La Santa Misa de hoy | Sábado después de Ceniza | 17-02-2024 | P. Santiago Martín, FM', medium.title)
    assert_equal('Canales de comunicación de Magnificat TV, proyecto evangelizador de los Franciscanos de María: Todo nuestro trabajo ...', medium.description)
    assert_equal('https://i.ytimg.com/vi/B78f1dXM4tU/default.jpg', medium.thumbnail_url)
    assert_equal(DateTime.parse('Sat, 17 Feb 2024 07:15:00.000000000 UTC +00:00'), medium.published_at)

    Medium.sync(date)
    # should not create additional LiturgicDay for the same date
    assert_equal 1, LiturgicDay.count
    assert_equal 1, CalendarDay.count
    assert_equal 2, Celebration.count
    assert_equal 1, Medium.count

  end
end
