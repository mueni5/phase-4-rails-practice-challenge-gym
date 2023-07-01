class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocesable_entity_response



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
        render json: gym
    end

    def update
        gym = Gym.find(params[:id])
        gym.update(gym_params)
        render json: gym
    end

    def destroy
        gym = find_gym
        gym.destroy
        head :no_content
    end

    private

    def lease_params
        params.permit(:membership, :gym_id, :client_id)
    end

    def find_gym
        Gym.find(params[:id])
    end

    def render_not_found_response
         render json: {error:"Gym not found"}, status: :not_found
    end

    def render_unprocesable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
