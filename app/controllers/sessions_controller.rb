class SessionsController < ApplicationController
  def new
  end

  def create
	
  	user = User.find_by(email: params[:session][:email].downcase)

  	if(user && user.authenticate(params[:session][:password]))
  		# 调整到用户资料界面
      log_in user
      if params[:session][:remember_me] == '1'
        remeber user
        else
        forget(user)
      end
      
      redirect_to user
  	else
  		# 显示错误信息
  		flash.now[:danger] = 'Invalid email/password combination '
  		render 'new'
  	end
  end

  def destory
      log_out
      redirect_to root_url
  end

end
