class InvitesController < ApplicationController
  respond_to :json, :html

  def index
    @event = Event.find(params[:event_id])
    @invites = Invite.where(event: @event).all

    respond_with @invites
  end

  def show
    @invite = Invite.find(params[:id])
    respond_with @invite
  end

  def create
    @event = Event.find(params[:event_id])
    @invite = Invite.new(params[:invite])
    @invite.event = @event
    respond_to do |format|
      if @invite.save
        format.html { redirect_to @invite, notice: 'Invite was successfully created.' }
        format.json { render json: @invite, status: :created, location: @invite }
      else
        format.html { render action: "new" }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @invite = Invite.find(params[:id])
    # TODO check that the invite belongs to this user

    respond_to do |format|
      if @invite.update_attributes(params[:invite])
        format.html { redirect_to @invite, notice: 'Invite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    respond_to do |format|
      format.html { redirect_to invites_url }
      format.json { head :no_content }
    end
  end
end
