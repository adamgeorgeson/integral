module Integral
  module Backend
    # Post management
    class PostsController < BaseController
      before_filter :set_post, only: [:edit, :update, :destroy, :show]
      before_filter :set_breadcrumbs

      # GET /
      # Lists all posts
      def index
        respond_to do |format|
          format.html do
            grid_options = {
              order: 'integral_posts.updated_at',
              order_direction: 'desc'
            }

            @posts_grid = initialize_grid(Post, grid_options)

            @published_posts_count = Integral::Post.published.count
            @draft_posts_count = Integral::Post.draft.count
          end

          format.json do
            respond_to_record_selector(Integral::Post)
          end
        end
      end

      # GET /new
      # Post creation form
      def new
        add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_backend_post_path
        @post = Post.new
      end

      # POST /
      # Post creation
      def create
        @post = Post.new(post_params)
        @post.user = current_user

        if @post.save
          respond_successfully(I18n.t('integral.backend.posts.notification.creation_success'), edit_backend_post_path(@post))
        else
          respond_failure(I18n.t('integral.backend.posts.notification.creation_failure'), :new)
        end
      end

      # GET /:id/edit
      # Post edit form
      def edit
        add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_backend_post_path
      end

      # PUT /:id
      # Updating a post
      def update
        if @post.update(post_params)
          respond_successfully(I18n.t('integral.backend.posts.notification.edit_success'), edit_backend_post_path(@post))
        else
          respond_failure(I18n.t('integral.backend.posts.notification.edit_failure'), :edit)
        end
      end

      # DELETE /:id
      def destroy
        if @post.destroy
          respond_successfully(I18n.t('integral.backend.posts.notification.delete_success'), backend_posts_path)
        else
          flash[:error] = I18n.t('integral.backend.posts.notification.delete_failure')
          redirect_to backend_posts_path
        end
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :slug, :body, :description, :tag_list, :image_id, :status)
      end

      def set_breadcrumbs
        add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :backend_dashboard_path
        add_breadcrumb I18n.t('integral.breadcrumbs.posts'), :backend_posts_path
      end
    end
  end
end
