class EventsController < ApplicationController

  respond_to :html, :json
  def index
    if !signed_in?
      return render json: {success: false}, status: :unauthorized
    end 
    @events = Event.where(user: current_user).all
    respond_with @events
  end

  def show
    @event = Event.find(params[:id])
    # TODO auth that the user is allowed to view this event
    respond_with @event
  end

  def join
    if !signed_in?
      return render json: {success: false}, status: :unauthorized
    end

    @event = Event.find(params[:id])
    @invite = Invite.create!
    @invite.event = @event
    @invite.invited_user = current_user
    @invite.save

    respond_with @event
  end

  def create
    # if user not logged in then return 401
    if !signed_in?
      return render json: {success: false}, status: :unauthorized
    end
    @event = Event.new(params[:event])
    @event.user = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
