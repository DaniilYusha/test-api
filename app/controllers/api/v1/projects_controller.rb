class Api::V1::ProjectsController < ApplicationController
  def index
    render json: { projects: Project.all }, status: :ok
  end

  def create
    project = Project.create(project_params)
    render json: { project: project }, status: :created
  end

  private

  def project_params
    params.permit(:name)
  end
end
