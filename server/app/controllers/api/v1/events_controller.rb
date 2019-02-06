class Api::V1::EventsController < ApplicationController

    before_action :find_event, only: [:update]

    def index
        @events = Event.all

        @event_with_guests = @events.map {|event| 
        {
            host: event.user_id,
            guests: event.users,
            title: event.title,
            date: event.date,
            latitude: event.latitude,
            longitude: event.longitude,
            capacity: event.capacity,
            image: event.image
        }
    }

        render json: @event_with_guests
    end

    def create
        @event = Event.new(title: params[:title], capacity: params[:capacity], image: params[:image], date: params[:date],latitude: params[:latitude], longitude: params[:longitude], user_id: current_user.id )

        if @event.save
            render json: @event
        else
            render json: {error: 'Unable to create event.'}, status: 400
        end
    end

    def show
        @event_with_guests = Event.find(params[:id])
        render json: {event_details: @event}
    end

    def update
        @event.update(title: params[:title], capacity: params[:capacity], image: params[:image], date: params[:date],latitude: params[:latitude], longitude: params[:longitude], user_id: current_user.id )

        if @event.save
            render json: @event, status: :accepted
        else
            render json: { errors: @event.errors.full_messages },
            status: :unprocessible_entity
        end
    end

    def destroy
        @event.delete
        head :no_content
    end

    private

    def find_event
        @event = Event.find(params[:id])
    end

end 
