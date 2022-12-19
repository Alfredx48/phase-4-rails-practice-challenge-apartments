class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found

  def index
    render json: Apartment.all, status: :ok
  end

  def show
    apartment = Apartment.find_by!(id: params[:id])
    render json: apartment, status: :ok
  end

  def update
    apartment = Apartment.find_by!(id: params[:id])
    apartment.update(apartment_params)
    render json: apartment, status: :accepted
  end

  def create
    apartment = Apartment.create!(apartment_params)
    render json: apartment, status: :created
  end

  def destroy
    apartment = Apartment.find_by!(id: params[:id])
    apartment.destroy
    head :no_content
  end

  private

  def rescue_not_found
    render json: { error: "Apartment not found" }, status: :not_found
  end

  def rescue_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def apartment_params
    params.permit(:number)
  end
end
