class SpicesController < ApplicationController

    # handle Active Record not found with private method: 
    rescue_from ActiveRecord::RecordNotFound, with: :render_spice_not_found_response

    #wrap parameters:
    wrap_parameters format: {}

    def index
        render json: Spice.all
    end

    # def show
    # end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice, status: :accepted
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content

    end

    private

    def find_spice
        Spice.find(params[:id])
    end

    def render_spice_not_found_response
        render json: {error: "data not found"}, status: :not_found
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
end
