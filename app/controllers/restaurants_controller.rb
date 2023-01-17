class RestaurantsController < ApplicationController
  before_action :set_resturant, only: [:edit, :show, :update, :destroy, :create_reviews]
  # skip_before_action :authenticate_user!
  #before_action :check_user, only: [:create, :new]


  def index
    @restaurants = Restaurant.all
  end

  def show; end

  def new
    @restaurant  = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.build(create_params)
    if @restaurant.save
      RestaurantDish.create(restaurant_id: @restaurant.id,dish_id: create_params[:dish_ids].is_a?(String) ? create_params[:dish_ids].split(',') : create_params[:dish_ids])
      redirect_to @restaurant
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    update_params = create_params
    update_params[:dish_ids] = create_params[:dish_ids].is_a?(String) ? create_params[:dish_ids].split(',') : create_params[:dish_ids]
    if @restaurant.present?
      @restaurant.update(update_params)
      redirect_to @restaurant
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @restaurant.present?
      @restaurant.destroy
      redirect_to root_path, status: :see_other
    end
  end

  def search_restro
    if params[:dish_id].present?
      restaurant_dishes = RestaurantDish.where(dish_id: params[:dish_id])
      @restaurants = []
      return render json: {message: "no data found"} if restaurant_dishes.blank?
      restaurant_dishes.each do |restro|
        restro = Restaurant.find_by_id(restro.restaurant_id)
        @restaurants << restro.as_json
      end
    # else
    #   return render json: {error: "dish_id not present"}, status: 400
    end
    redirect_to :index
  end

  def update_restro_status
    status_update(params[:id],params[:status])
    restro = Restaurant.find_by(id: params[:id])
    render json: {restro: restro,message: "your status will be updated after 5 minutes"}
  end

  def create_reviews
    param = review_params
    param[:user_id] = current_user.id
    restro = @restaurant.reviews.create(param)
    render json: {review: restro},status: 200
  end

  private

  def set_resturant
    @restaurant = Restaurant.find(params[:id])
  end
  
  # def check_user
  #   if current_user.User?
  #     flash[:alert] = "Only Admin can create Restaurants"
  #   end
  # end

  def create_params
    params.require(:restaurant).permit(:user_id,:name,:city,:state,:phone_number,:restro_type,:status, :dish_ids => [])
  end

  # background job sidekiq for restaurants status update
  def status_update(id,status)
    Restaurants::RestroWorker.perform_at(5.minutes.from_now,id,status)
  end

  def review_params
    params.require(:data).permit(:rating, :comment, :user_id)
  end
end
