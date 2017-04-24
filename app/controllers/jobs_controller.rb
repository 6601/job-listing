class JobsController < ApplicationController

	def index
		@jobs  =Job.where(:is_hidden => false).recent
		
	end

	def new
		@job =Job.new
	end
	
	def show
    @job = Job.find(params[:id])

    if@job.is_hidden
    	flash[:warning]= "出错了"
    	redirect_to root_path
    end

  	end



end
