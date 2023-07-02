class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
    def index
      gyms = Gym.all
      render json: gyms
    end
  
    def create
      gym = Gym.create!(gym_params)
      render json: gym, status: :created
    end
  
    def show
      gym = find_gym
      if gym
        render json: gym
      else
        render_not_found_response
      end
    end
  
    def update
      gym = find_gym
      if gym
        gym.update(gym_params)
        render json: gym
      else
        render_not_found_response
      end
    end
  
    def destroy
      gym = find_gym
      if gym
        gym.destroy
        head :no_content
      else
        render_not_found_response
      end
    end
  
    private
  
    def gym_params
      params.permit(:name, :address)
    end
  
    def find_gym
      Gym.find_by(id: params[:id])
    end
  
    def render_not_found_response
      render json: { error: "Gym not found" }, status: :not_found
    end
  
    def render_unprocessable_entity_response(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
  end
  