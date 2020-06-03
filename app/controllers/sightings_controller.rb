class SightingsController < ApplicationController
    def index
        sighting = Sighting.all
        if sighting
            render json: sighting, include: [:bird, :location] 
        # rails is just obscuing this part: render json: sightings.to_json(include: [:bird, :location])
        else
            render json: { message: 'No sighting found with that id'}
        end
    end

    def show
        sighting = Sighting.find_by(id: params[:id])
        # render json: sighting, include: [:bird, :location] or for nested use render method below
        render json: sighting.to_json(:include => {
        :bird => {:only => [:name, :species]},
        :location => {:only => [:latitude, :longitude]}
        }, :except => [:updated_at])

    end
end
