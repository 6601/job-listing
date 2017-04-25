class JobsController < ApplicationController

	def index
		# @jobs  =Job.where(:is_hidden => false).recent
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
    @job = Job.find(params[:id])

    if@job.is_hidden
    	flash[:warning]= "出错了"
    	redirect_to root_path
    end

  	end



end
