class SuggestionsController < ApplicationController
  respond_to :json, :html

  def index
    @event = Event.find(params[:event_id])
    @suggestions = Suggestion.where(event: @event).all
    respond_with @suggestions
  end

  def show
    @suggestion = Suggestion.find(params[:id])
    respond_with @suggestion
  end

  def create
    @event = Event.find(params[:event_id])
    @suggestion = Suggestion.new(params[:suggestion])
    @suggestion.event = @event

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully created.' }
        format.json { render json: @suggestion, status: :created, location: @suggestion }
      else
        format.html { render action: "new" }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @suggestion = Suggestion.find(params[:id])
    # TODO check that the suggestion belongs to this user

    respond_to do |format|
      if @suggestion.update_attributes(params[:suggestion])
        format.html { redirect_to @suggestion, notice: 'Suggestion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @suggestion = Suggestion.find(params[:id])
    @suggestion.destroy

    respond_to do |format|
      format.html { redirect_to suggestions_url }
      format.json { head :no_content }
    end
  end
end
