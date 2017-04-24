class Admin::JobsController < ApplicationController
	before_action :authenticate_user!,only:[:new,:create,:update,:edit,:destroy]
	before_action :set_admin_job,only:[:show,:edit,:update,:destroy]
	before_action :require_is_admin

	def index
		@jobs =Job.all
		
	end

	def new
		@job =Job.new
		
	end

	def show
		
	end

	def edit
		
	end

	def destroy
		@job.destroy
		redirect_to admin_jobs_path
		
	end

	def create
		@job=Job.new(job_params)
		if @job.save
			redirect_to admin_jobs_path
		else
			render :new
			
		end
	end

	def update
		if @job.update(job_params)
			redirect_to admin_jobs_path
		else
			render :edit
		end
		
	end

	private

	def set_admin_job
		@job =Job.find(params[:id])
		
	end

	def job_params
		params.require(:job).permit(:title,:description,:wage_upper_bound,:wage_lower_bound,:contact_email)
	end
end
