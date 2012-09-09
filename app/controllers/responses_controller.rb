class ResponsesController < ApplicationController
  respond_to :json, :html

  def index
    @suggestion = Suggestion.find(params[:suggestion_id])
    @responses = Response.where(suggestion: @suggestion).all

    respond_with @responses
  end

  def show
    @response = Response.find(params[:id])
    respond_with @response
  end

  def create
    @suggestion = Suggestion.find(params[:suggestion_id])
    @response = Response.new(params[:response])
    @response.suggestion = @suggestion

    respond_to do |format|
      if @response.save
        format.html { redirect_to @response, notice: 'Response was successfully created.' }
        format.json { render json: @response, status: :created, location: @response }
      else
        format.html { render action: "new" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @response = Response.find(params[:id])

    respond_to do |format|
      if @response.update_attributes(params[:response])
        format.html { redirect_to @response, notice: 'Response was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @response.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @response = Response.find(params[:id])
    @response.destroy

    respond_to do |format|
      format.html { redirect_to responses_url }
      format.json { head :no_content }
    end
  end
end
