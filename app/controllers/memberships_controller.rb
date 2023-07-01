class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocesable_entity_response



    def index
        memberships = Membership.all
        render json: memberships
    end

    def create
        memberships = Membership.create!(membership_params)
        render json: membership, status: :created
    end

    def show
        membership = Membership_params
        render json: membership
    end

    def update
        memberships = Membership.find(params[:id])
        membership.update(apartment_params)
        render json: apartment
    end

    def destroy
     membership = find_membership
        membership.destroy
        head :no_content
    end

    private

    def membership_params
        params.permit(:number)
    end

    def find_membership
        membership.find(params[:id])
    end

    def render_not_found_response
         render json: {error:"Client not found"}, status: :not_found
    end

    def render_unprocesable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

end
