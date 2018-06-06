class TasksController < ApplicationController
	DEFAULT_STATUS = 1
	def index
		@tasks = Task.all
	end

	def new
		@task = Task.new
	end

	def edit
		@task = Task.find(params[:id])
		render 'edit' 
	end

	def update 
		task_params = params[:task]

		@task = Task.find(params[:id])
		
		@task.title = task_params[:title]
		@task.description = task_params[:description]
		@task.status = task_params[:status]

		t_start = build_date_time("start", task_params)
		t_end = build_date_time("end", task_params)

		@task.start = t_start
		@task.end = t_end

		if @task.save
			redirect_to '/dash'
		else 
			render 'edit'
		end
	end

	def create
		@task = Task.new(task_params)

		t_start = build_date_time("start", task_params)
		t_end = build_date_time("end", task_params)

		@task.status = DEFAULT_STATUS
		@task.user_id = session[:user_id]

		if (t_end < t_start)
			t_end = t_start
		end

		@task.start = t_start
		@task.end = t_end
		
		if @task.save
			redirect_to '/dash'
		else
			render 'new'
		end
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
		def task_params_without_start
			params.require(:task).permit(:title, :description, :status, :end)
		end

		def task_params
			params.require(:task).permit(:title, :description, :status, :end, :start)
		end

		def build_date_time(prefix, params)
			return Time.new( 
				params[prefix + "(1i)"],
				params[prefix + "(2i)"],
				params[prefix + "(3i)"],
				params[prefix + "(4i)"],
				params[prefix + "(5i)"])
		end
end
