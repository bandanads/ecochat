class EcosController < ApplicationController
  before_action :authenticate_user!
 
  def index
   
    @ecos= Eco.all.order(created_at: :desc)
    @tags = Tag.all
    @ecos = @ecos.where("title LIKE ? ",'%' + params[:search] + '%') if params[:search].present?
    
    if params[:tag_ids].present?
      eco_ids = []
      params[:tag_ids].each do |key, value| 
        if value == "1"
          Tag.find_by(name: key).ecos.each do |p| 
            eco_ids << p.id
          end
        end
      end
      eco_ids = eco_ids.uniq
      
      @ecos = @ecos.where(id: eco_ids) if eco_ids.present?
    end
   
    
    
   
   
    @rank_tweets = Eco.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(3)
 end


 
 def new
    @eco = Eco.new
 end

 

 def create
   eco = Eco.new(eco_params)
   eco.user_id = current_user.id
   if eco.save
    redirect_to :action => "index"
   else
    redirect_to :action => "new"
  end
 end

 def show
    @eco = Eco.find(params[:id])
  
    @comments = @eco.comments
    @comment = Comment.new
 end

 def edit
   @eco = Eco.find(params[:id])
 end
   
 

 def update
    eco = Eco.find(params[:id])
    if eco.update(eco_params)
      redirect_to :action => "show", :id => eco.id
    else
      redirect_to :action => "new"
    end

  end
 
 def destroy
    eco = Eco.find(params[:id])
    eco.destroy
    
    redirect_to action: :index
 end

 
 private
 def eco_params
    params.require(:eco).permit(:body, :image, :title, tag_ids: [])
 end
 
end
