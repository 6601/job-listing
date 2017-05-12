class Admin::JobsController < ApplicationController
	before_action :authenticate_user!,only:[:new,:create,:update,:edit,:destroy]
	before_action :set_admin_job,only:[:show,:edit,:update,:destroy,:publish,:hide]
	before_action :require_is_admin
	layout "admin"

	def index
		# @jobs =Job.all.recent
		@jobs = case params[:order]
            when 'by_lower_bound'
              Job.published.order('wage_lower_bound DESC')
            when 'by_upper_bound'
              Job.published.order('wage_upper_bound DESC')
            else
              Job.published.recent
            end
		
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

	def publish
		@job.publish!
		redirect_to :back
		
	end

	def hide
		@job.hide!
		redirect_to :back
		
	end

	private

	def set_admin_job
		@job =Job.find(params[:id])
		
	end

	def job_params
		params.require(:job).permit(:title,:description,:wage_upper_bound,:wage_lower_bound,:contact_email,:contact_address,:contact_phone,:is_hidden)
	end
end
