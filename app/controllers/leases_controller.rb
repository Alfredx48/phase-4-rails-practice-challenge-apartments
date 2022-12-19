class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found

  def index
    render json: Lease.all, status: :ok
  end

  def show
    lease = Lease.find_by!(id: params[:id])
    render json: lease, status: :ok
  end

  def update
    lease = Lease.find_by!(id: params[:id])
    lease.update(lease_params)
    render json: lease, status: :accepted
  end

  def create
    lease = Lease.create!(lease_params)
    render json: lease, status: :created
  end

  def destroy
    lease = Lease.find_by!(id: params[:id])
    lease.destroy
    head :no_content
  end

  private

  def rescue_not_found
    render json: { error: "Lease not found" }, status: :not_found
  end

  def rescue_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def lease_params
    params.permit(:apartment_id, :tenant_id, :rent)
  end
end
