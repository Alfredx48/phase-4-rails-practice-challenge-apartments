class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found

  def index
    render json: Tenant.all, status: :ok
  end

  def show
    tenant = Tenant.find_by!(id: params[:id])
    render json: tenant, status: :ok
  end

  def update
    tenant = Tenant.find_by!(id: params[:id])
    tenant.update(tenant_params)
    render json: tenant, status: :accepted
  end

  def create
    tenant = Tenant.create!(tenant_params)
    render json: tenant, status: :created
  end

  def destroy
    tenant = Tenant.find_by!(id: params[:id])
    tenant.destroy
    head :no_content
  end

  private

  def rescue_not_found
    render json: { error: "Tenant not found" }, status: :not_found
  end

  def rescue_invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def tenant_params
    params.permit(:name, :age)
  end
end
