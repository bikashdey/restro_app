module Restaurants
  class RestroWorker
    include Sidekiq::Worker

    def perform(id,status)
      restro = Restaurant.find_by(id: id)
      restro.update(status: status)
    end
  end
end
