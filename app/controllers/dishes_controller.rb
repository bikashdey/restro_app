class DishesController < ApplicationController
  def index
    @dishes = Dish.all
    render json: {dishes: @dishes},status: 200 if @dishes.present?
    render json: {dishes: @dishes},status: 200 if @dishes.blank?
  end
  def create
    dish = Dish.new(create_params)
    if dish.save
      render json: {dish: dish},status: 200
    else
      render json: {error: dish.errors.full_messages},status: 400
    end
  end

  def create_reviews
    dish = Dish.find(params[:id]) 
    param = review_params
    param[:user_id] = current_user.id  
    dishes = dish.reviews.create(param)
    render json: {review: dishes},status: 200
  end


  def new
  end

  def edit
  end

  def update
    dish = Dish.find(params[:id])
    update_params = create_params
    if dish.update(update_params)
      render json: {restro: restro},status: 200
    else
      render json: {error: restro.errors.full_messages},status: 400
    end
  end

  def show
    @dish = Dish.find(params[:id])
    render :show
  end

  def destroy
    @dish = Dish.find(params[:id])
    if @dish.present?
      @dish.destroy
      render json: {message: "dish deleted successfully"},status: 200
    else
      render json: {message: "dish not present"},status: 404
    end
  end

  private 
  def create_params
    params.require(:data).permit(:name, :dish_type, :price)
  end

  def review_params
    params.require(:data).permit(:rating, :comment, :user_id)
  end
end
