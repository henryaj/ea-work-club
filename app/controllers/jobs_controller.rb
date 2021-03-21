class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy, :upvote, :renew]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_owner_logged_in, only: [:edit, :update, :destroy, :renew]

  impressionist actions: [:show]

  # GET /jobs
  # GET /jobs.json
  def index
    if params[:category_id]
      @categories = Category.where(id: params[:category_id])
    else
      @categories = Category.all
    end

    if params[:remote]
      @title = "Remote Jobs"
      @jobs = Job.displayable_sorted_by_expiry.select(&:remote?)
    else
      @jobs = Job.displayable_sorted_by_expiry
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    if owner_logged_in?
      @show_edit_controls = true
    else
      @show_edit_controls = false
    end
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params.merge({
      owner_id: current_user_id,
      owner_name: current_user_name,
      user_id: current_user_db_record.id,
      remote: job_params[:remote]
    }))

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # GET /jobs/1/renew
  def renew
    @job.renew!

    redirect_to @job, notice: 'Project was successfully renewed.'
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit(
      :title,
      :location,
      :description, # old, text-only description. We include it to allow display and editing of old listings
      :content,     # new, Trix rich-text description
      :time_commitment,
      :organisation,
      :url,
      :expiry_date,
      :category_id,
      :remote
    )
  end

  def check_owner_logged_in
    unless owner_logged_in?
      redirect_to jobs_url, notice: "You don't have permission to do that."
    end
  end

  def owner_logged_in?
    @job.owner_id == current_user_id || user_is_admin?
  end
end
