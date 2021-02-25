class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do #index action
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do #new action step 1
    erb :new
  end

  post '/recipes' do #new action step 2
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do #show action
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do #edit action step 1
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #edit action step 2
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do #delete action
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

end
