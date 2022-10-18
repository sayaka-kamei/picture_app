class PicturesController < ApplicationController
  before_action :ensure_current_user, {only: [:edit, :update]}

  def index
    @pictures = Picture.all
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end
  
  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else  
      if @picture.save
        redirect_to pictures_path, notice: "作成しました！"
        ContactMailer.contact_mail(current_user).deliver
      else
        render :new
      end
    end  
  end
  
  def show
    @picture = Picture.find(params[:id])
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def ensure_current_user
    if current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to picture_path
    end
  end

  def edit
    @picture = Picture.find(params[:id])
  end  

  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "編集しました！"
    else
      render :edit
    end   
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path, notice:"削除しました！"
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private

  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content, :user_id)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end  
end

