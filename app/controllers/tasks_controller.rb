class TasksController < ApplicationController
	def index
		@tasks = Task.all
	end

	def new
	end

	def edit
		@task = Task.find(params[:id])
		render 'edit' 
	end

	def update 
		_taskParams = params[:task]

		@task = Task.find(params[:id])
		
		@task.title = _taskParams[:title]
		@task.description = _taskParams[:description]
		@task.status = _taskParams[:status]

		@task.end = build_date_time(_taskParams)

		@task.save

		redirect_to '/dash'
	end

	def create
		@task = Task.new(task_params)

		@task.status = 0
		@task.end = build_date_time(task_params)
		
		@task.save
		redirect_to '/dash'
	end

	def show
		@task = Task.find(params[:id])
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		
		redirect_to '/dash'
	end

	private 
		def task_params
			params.require(:task).permit(:title, :description, :status, :end)
		end

		def build_date_time(params)
			return Time.new( 
				params["end(1i)"],
				params["end(2i)"],
				params["end(3i)"],
				params["end(4i)"],
				params["end(5i)"])
		end
end
