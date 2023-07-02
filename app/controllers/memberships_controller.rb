class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  
    def index
      memberships = Membership.all
      render json: memberships
    end
  
    def create
      membership = Membership.create!(membership_params)
      render json: membership, status: :created
    end
  
    def show
      membership = find_membership
      if membership
        render json: membership
      else
        render_not_found_response
      end
    end
  
    def update
      membership = find_membership
      if membership
        membership.update(membership_params)
        render json: membership
      else
        render_not_found_response
      end
    end
  
    def destroy
      membership = find_membership
      if membership
        membership.destroy
        head :no_content
      else
        render_not_found_response
      end
    end
  
    private
  
    def membership_params
      params.permit(:gym_id, :client_id, :charge)
    end
  
    def find_membership
      Membership.find_by(id: params[:id])
    end
  
    def render_not_found_response
      render json: { error: "Membership not found" }, status: :not_found
    end
  
    def render_unprocessable_entity_response(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
  end
  