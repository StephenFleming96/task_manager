class TaskStatus < ActiveRecord::Base
  enum task_status: {not_started: 0, in_progress: 1, done: 2}
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  STATUS_CLASS_MAP = {0 => 'task-not-started', 1 => 'task-in-progress', 2 => 'task-done', 3 => 'task-error'}

  def index
    if (session[:user_id] == nil || session[:expiry] == nil || session[:expiry] < Time.current)
      redirect_to '/login'
    else
      @tasks = Task.all.sort_by{|t| t.status.to_i}

      render 'dash'
    end
  end

  def self.int_to_status(status)
    case status
      when 0
        return 'Not Started'
      when 1
        return 'In Progress'
      else 
        return 'Done'
    end
  end

  def self.class_for_status(status)
    return STATUS_CLASS_MAP[status]
  end
end

