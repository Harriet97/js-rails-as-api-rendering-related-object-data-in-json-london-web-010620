class SightingsController < ApplicationController
    def index
        sightings = Sighting.all
        render json: sightings, include: [:bird, :location], except: [:updated_at]
    end
    def show
        sighting = Sighting.find_by(id: params[:id])
        # render json: { id: sighting.id, bird: sighting.bird, location: sighting.location}
        #error message:
        if sighting
            render json: sighting.to_json(:include => {
                :bird => {:only => [:name, :species]},
                :location => {:only => [:latitude, :longitude]}            
            }, :except => [:updated_at])
        else
            render json: { message: 'No sighting found witht that id'}
        end
    end
end
