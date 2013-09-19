#===================== GET ROUTES ====================================

#routes to home
get '/' do
  erb :index
end


#routes to new-user form
get '/users/new' do
  erb :new
end

#user's log-in page
get '/users/:id' do
  
  @user = User.find_by_id(params[:id])
  if @user.id == session[:id]
    # if @user.authenticate
      erb :secret
    # end
  else
    redirect "/"
  end
end

#routes to logout page, ends user session
get '/logout' do
  session[:id] = nil
  erb :logout
end


#======================= POST ROUTES=================================

#creates a new user

post '/users/new' do
  # @user_new = User.new(username: params[:username], first_name: params[:first_name], last_name: params[:last_name], phone: params[:phone], password_digest: params[:password], email: params[:email])
  @user = User.new(params[:user])
  
  if @user.save
    session[:id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    
    erb :new
  end

end

#login existing user

post '/login' do
  @user = User.find_by_username(params[:user][:username])
  
  if @user && @user.authenticate(params[:user][:password])
    session[:id] = @user.id 
    redirect "/users/#{@user.id}"
  else
    # @errors << ["The username and/or password you entered is faulty."]
    # puts @errors.last
    @errors = ["The username and/or password you entered is incorrect."]
    erb :index
  end
end


# Delete user from users.

post '/users/:id/delete' do
  @user = User.find(params[:id])
  @user.destroy
  session[:id] = nil
  redirect '/users'
end

# Update users
# post '/users/:id/edit' do
#   @user = User.find(params[:id])
#   @user.update()
#   erb: edit
# end

