class Api::V1::EventsController < ApplicationController

    before_action :find_event, only: [:update]

    def index
        @events = Event.all

        # @event_with_guests = @events.map {|event| 
        # {   
        #     id: event
        #     host: event.user_id,
        #     guests: event.users,
        #     title: event.title,
        #     date: event.date,
        #     latitude: event.latitude,
        #     longitude: event.longitude,
        #     capacity: event.capacity,
        #     image: event.image
        # }
    # }

        render json: @events.as_json(include:{users: {
            except: [:password_digest]
        }})
    end

    def create

        @event = Event.new(title: params[:title], capacity: params[:capacity], image: params[:image], date: params[:date],latitude: params[:latitude], longitude: params[:longitude], host: params[:host], user_id: current_user.id )

        if @event.save
            render json: @event

        else
            render json: {error: 'Unable to create event.'}, status: 400
        end

    end

    def show
        @event = Event.find(params[:id])


        render json: @event.as_json(include:{users: {
            except: [:password_digest]
        }})
    end

    def joinevent

        joined_user_event = UserEvent.create!(user_id: current_user.id,
        event_id: params[:event_id])

        joined_user_event.save

    end

    def cancelevent
        user_event = UserEvent.find_by(:user_id => current_user.id, :event_id => params[:event_id])

         user_event.destroy
    end
    
    def joined_user_event
        joined_event = UserEvent.find_by(:id => current_user.id)

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

    def deleteevent
        @deleted_user_event = UserEvent.find_by(:event_id => params[:event_id])

         @deleted_event = Event.find_by(:id => params[:id]
         )

        @deleted_user_event.destroy
        @deleted_event.destroy
    end



    private

    def find_event
        @event = Event.find(params[:id])
    end

end 
