class JobsController < ApplicationController

	def index
		@jobs  =Job.where(:is_hidden => false).recent
		
	end

	def new
		@job =Job.new
	end
	
	def show
    @job = Job.find(params[:id])
  	end



end
