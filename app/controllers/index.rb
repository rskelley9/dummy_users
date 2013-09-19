#===================== GET ROUTES ====================================

get '/' do
  @task = params[:task]
  erb :index
end

get '/users/existing_user' do
  erb :existing_user
end

get '/users/new' do
  erb :new
end

get '/login' do
  erb :login
end


get '/logout' do
  session[:user_id] = nil
  redirect '/'
end


#======================= POST ROUTES=================================

#login and authenticate the user

# post '/login' do
#   @user = User.find_by_email(params[:user][:email])
#   if @user && @user.authenticate(params[:user][:password])
#     session[:user_id] = @user.id 
#     redirect "/users/#{@user.id}"
#   else
#     @errors = ["That username/password does not exist"]
#     erb :index
#   end

#creates a new user

post '/new' do
  @user_new = User.new(username: params[:name], password: params[:pass], email: params[:email])
  @user = User.new(params[:user])
  
  if @user.save
    session[:user_id] = @user.id
    redirect to "/users/#{@user.id}"
  else
    @errors = @user.errors.full_messages
    erb :new
  end
end

#login existing user

post '/existing_user' do

  @users = User.all
  @user_existing = @users.where[username: params[:name], password: params[:pass]]

  if @user_existing
    erb :secret
  else
    @errors = ["That username/password does not exist"]
    redirect "/"
  end 
end

# # Update a user with data from the form
# post '/users/:id' do
#   @user = User.find(params[:id])
#   if @user.update_attributes(params[:user])
#     redirect to "/users/#{@user.id}"
#   else
#     erb :edit
#   end
# end

# # Delete a user
# post '/users/:id/delete' do
#   @user = User.find(params[:id])
#   @user.destroy
#   redirect to '/users'
# end

# post '/login' do
#   @user = User.find_by_email(params[:user][:email])
#   if @user && @user.authenticate(params[:user][:password])
#     session[:user_id] = @user.id 
#     redirect "/users/#{@user.id}"
#   else
#     @errors = ["That username/password does not exist"]
#     erb :index
#   end
#   # authenticate
#   # set the session
#   # redirect to users/:id page
# end


#   if @user_new.save
#     erb :succes_page
#   else
#     @error = @url_new.errors.messages[:original][0]
#     @url = Url.find(:all, :order => "id desc", :limit => 5)
#     erb :index
#   end

# end

# # get '/users' do
# #   @users = User.order('last_name ASC') # sort them by alphabetical order by last_name
# #   erb :index
# # end


# # Retrieve the resource with the id from the url
# get '/users/:id' do
#   # we should have a current_user now
#   @user = User.find_by_id(params[:id])
#   if @user.id == session[:user_id]
#     # if @user.authenticate
#       erb :secret
#     # end
#   else
#     redirect "/"
#   end
# end
