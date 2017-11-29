FactoryBot.define do
    factory :event do
      name "Test Event"
      event_tm_id "testevent"
      date Time.now + 1.month
      created_at Time.now
      updated_at Time.now
      artist_id "1"
      venue_id "1"
      user_id "1"

   end
end