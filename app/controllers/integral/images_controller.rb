module Integral
  # Images controller
  class ImagesController < ApplicationController
    before_filter :set_image, only: [:edit, :update, :destroy, :show]
    before_filter :authorize_with_klass, only: [ :index, :new, :create, :edit, :update, :destroy ]

    add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :root_path
    add_breadcrumb I18n.t('integral.breadcrumbs.images'), :img_index_path

    # GET /
    # Lists all images
    def index
      @images = Image.all.order('created_at DESC')
      @image = Image.new
    end

    # GET /new
    # Image creation form
    def new
      add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_img_path
      @image = Image.new
    end

    # POST /
    # Image creation
    def create
      @image = Image.new(image_params)

      if @image.save
        render status: :created, partial: 'card', locals: { image: @image, card_class: 'hide' }
      else
        render status: :unprocessable_entity, nothing: true
      end
    end

    # GET /:id/edit
    # Image edit form
    def edit
      add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_img_path
    end

    # PUT /:id
    # Updating an image
    def update
      if @image.update(image_params)
        flash[:notice] = 'Image successfully updated.'
        redirect_to img_index_path
      else
        render 'edit'
      end
    end

    # DELETE /:id
    def destroy
      flash[:notice] = 'Image successfully deleted.' if @image.destroy
      redirect_to img_index_path
    end

    private

    def authorize_with_klass
      authorize Image
    end

    def set_image
      @image = Image.find(params[:id])
    end

    def image_params
      params.require(:image).permit(:title, :description, :file)
    end
  end
end
