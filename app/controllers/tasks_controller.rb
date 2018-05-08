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
		@task.end = _taskParams[:end]

		@task.save

		redirect_to '/dash'
	end

	def create
		@task = Task.new(task_params)

		@task.status = 0
		
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

end
