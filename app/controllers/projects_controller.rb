class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :upvote, :renew]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :upvote]
  before_action :check_owner_logged_in, only: [:edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all.sort_by {|p| p.votes_for.size }.reverse
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    if owner_logged_in?
      @show_edit_controls = true
    else
      @show_edit_controls = false
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params.merge({
      owner_id: current_user_id,
      owner_name: current_user_name,
      user_id: current_user_db_record.id
    }))

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # GET /projects/1/upvote
  def upvote
    # if user has already voted, remove that vote
    if current_user_db_record.voted_for?(@project)
      @project.unliked_by(current_user_db_record)
    else
      @project.liked_by(current_user_db_record)
    end

    redirect_back(fallback_location: root_path)
  end

  # GET /projects/1/renew
  def renew
    @project.renew!

    redirect_to @project, notice: 'Project was successfully renewed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:title, :description, :organisation, :contact_email, :budget, :category_id)
  end

  def check_owner_logged_in
    unless owner_logged_in?
      redirect_to projects_url, notice: "You don't have permission to do that."
    end
  end

  def owner_logged_in?
    @project.owner_id == current_user_id || user_is_admin?
  end
end
