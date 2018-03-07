class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    if params[:category_id]
      @categories = Category.where(id: params[:category_id])
    else
      @categories = Category.all
    end

    @jobs = Job.all.order(expiry_date: :asc).reject(&:expired?)
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
    redirect_to jobs_url, notice: "You don't have permission to do that." unless @job.owner_id == current_user_id
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params.merge({
      owner_id: current_user_id,
      owner_name: current_user_name,
      user_id: current_user_db_record.id
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

  private

  def set_job
    @job = Job.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def job_params
    params.require(:job).permit(:title, :location, :description, :time_commitment, :organisation, :url, :expiry_date, :category_id)
  end
end
