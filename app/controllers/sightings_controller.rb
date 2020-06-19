class SightingsController < ApplicationController
  def show
    sighting = Sighting.find_by(id: params[:id])
    # CONVENTIONAL: render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }
    
    # FULL to_json SYNTAX
    # sighting = Sighting.find_by(id: params[:id])
    # render json: sighting.to_json(:include => {
    #   :bird => {:only => [:name, :species]},
    #   :location => {:only => [:latitude, :longitude]}
    # }, :except => [:updated_at])
    

    # MANAGE ERROR OR MISSING DATA
    if sighting
      # USING include:    
      render json: sighting, include: [:bird, :location],
      # REMOVING except:
      except: [:updated_at]
    else
      render json: { message: 'No sighting found with that id '}
    end

  end

  def index
    sightings = Sighting.all
    render json: sightings, include: [:bird, :location]
  end
end
