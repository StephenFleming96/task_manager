require 'action_view'
include ActionView::Helpers::DateHelper

class TaskStatus < ActiveRecord::Base
  enum task_status: {not_started: 0, in_progress: 1, done: 2}
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  STATUS_CLASS_MAP = {0 => 'task-in-progress', 1 => 'task-not-started', 2 => 'task-done', 3 => 'task-error'}

  def index
    if (!session[:user_id] || !session[:expiry] || session[:expiry] < Time.current)
      redirect_to '/login'
    else
      @user = User.find(session[:user_id])
      @tasks = Task.where(:user_id => @user.id).sort_by{|t| t.status.to_i}

      render 'index'
    end
  end

  def self.int_to_status(status)
    case status
      when 0
        return 'In Progress'
      when 1
        return 'Not Started'
      else 
        return 'Done'
    end
  end

  def self.class_for_status(status)
    return STATUS_CLASS_MAP[status]
  end

  def self.time_until(time)
    dotiw = distance_of_time_in_words(Time.now, time, include_seconds: false) 
    if (time < Time.now)
      dotiw = "#{dotiw} ago"
    end

		return dotiw
  end
  
  def self.build_time_until_string(task)
    time = task.end
    time_until = ApplicationController.time_until(time)
 
    span_class = ""
    if task.status != 2
      if time_until.include? "ago"
        span_class = "red-text"
      elsif (time_until.include? "hour" or time_until.include? 'minute') 
        span_class = "yellow-text"
      end
    end

    ret_str = "<span class='#{span_class}'>#{time_until}</span>"
    return ret_str.html_safe
  end
end

