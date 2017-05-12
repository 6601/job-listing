class JobsController < ApplicationController
  before_action :validate_search_key, only: [:search]

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

  def search
    if @query_string.present?
    search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
    @jobs = search_result.recent.paginate(:page => params[:page], :per_page => 5 )
    end
  end

protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "")
    if params[:q].present?
      @search_criteria =  {
        title_cont: @query_string
      }
    end
  end

  def search_criteria(query_string)
    { :title_cont => query_string }
  end

def job_params
    params.require(:job).permit(:title,:description,:wage_upper_bound,:wage_lower_bound,:contact_email,:contact_address,:contact_phone,:is_hidden)
  end

end
