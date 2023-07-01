class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocesable_entity_response



    def index
        clients = Client.all
        render json: client
    end

    def create
        client = Client.create!(tenant_params)
        render json: client, status: :created
    end

    def show
        client = find_client
        render json: client
    end

    def update
        client = Client.find(params[:id])
        client.update(client_params)
        render json: client
    end

    def destroy
        client = find_tenant
        client.destroy
        head :no_content
    end

    private

    def client_params
        params.permit(:name, :age)
    end

    def find_tenant
        Client.find(params[:id])
    end

    def render_not_found_response
         render json: {error:"Apartment not found"}, status: :not_found
    end

    def render_unprocesable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
