class SightingsController < ApplicationController
  def show
    sighting=Sighting.find_by(id: params[:id])
    #render json: {id: sighting.id, bird: sighting.bird, location: sighting.location}
    if sighting
      render json: sighting, include: [:bird=>{:only=>[:name,:species]}, :location=>{:only=>[:latitude,:longitude]}], except: [:updated_at]
    else
      render json: {message: 'No sighting found with that id'}
    end
  end

  def index
    sightings=Sighting.all
    render json: sightings, include: [:bird,:location]
  end
end
