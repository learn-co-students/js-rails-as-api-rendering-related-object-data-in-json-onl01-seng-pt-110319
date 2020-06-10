class SightingsController < ApplicationController
    
    def index
        sightings = Sighting.All 
        render json: sightings, include: [:bird, :location]
    end

    def show
        sighting = Sighting.find_by(id: params[:id])
        if sighting
            #render json: sighting, include: [:bird, :location], except: [:updated_at]
            #Using the .to_json helps developers more elequently include and exclude data
            render json: sighting.to_json(:include => {
                :bird => {:only => [:name, :species]},
                :location => {:only => [:longitude, :latitude]}
                }, :only => [:id])
        else 
           render json: {message: 'No sighting found with that ID'} 
        end
    end
end
