class GeocodeController < ApplicationController
  respond_to :json
  
  def resolve
    query = params[:q]
    results = Geocoder.search(query)
    if results.blank?
      return render json: {success: false, message: "no results found for '#{query}'"}, status: :not_found
    end
    result = results.first

    return render(json: {coordinates: result.coordinates, address: result.formatted_address}, status_code: 200)
  end
  
end
