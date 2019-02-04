class Api::V1::EventsController < ApplicationController
    def create
        @event = Event.new(title: params[:title], capacity: params[:capacity], image: params[:image], date: params[:date],latitude: params[:latitude], longitude: params[:longitude], user_id: current_user.id )

        if @event.save
            render json: @event
        else
            render json: {error: 'Unable to create event.'}, status: 400
        end
    end
end
