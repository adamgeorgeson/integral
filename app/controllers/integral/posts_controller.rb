module Integral
  # Posts controller
  class PostsController < BlogController
    prepend_before_filter :find_post, only: [:show]
    before_filter :find_related_posts, only: [:show]
    after_filter :increment_post_count, only: [:show]

    # GET /
    # List blog posts
    def index
      @posts = Integral::Post.published.order('published_at DESC').paginate(:page => params[:page]).to_a
    end

    # GET /blog.slug
    # Presents blog postings
    def show
      add_breadcrumb @post.title, :post_url

      @meta_data = {
        page_title: @post.title,
        page_description: @post.description,
        open_graph:  {
          image: @post.image&.file&.url
        }
      }
    end

    private

    def increment_post_count
      @post.increment_count!(request.ip)
    end

    # Creates array with 4 related posts. If 4 do not exist uses popular posts to fill the gaps
    def find_related_posts
      @related_posts = @post.find_related_tags.limit(4)
      amount_of_related_posts = @related_posts.length

      if amount_of_related_posts != 4 && (amount_of_related_posts + @popular_posts.length) >= 4
        @related_posts.concat(@popular_posts[0...4-amount_of_related_posts])
      end
    end

    def find_post
      if current_user.present?
        @post = Integral::Post.friendly.find(params[:id]).decorate
      else
        @post = Integral::Post.friendly.published.find(params[:id]).decorate
      end

      @post.decorate

      # If an old id or a numeric id was used to find the record, then
      # the request path will not match the post_path, and we should do
      # a 301 redirect that uses the current friendly id.
      if request.path != post_path(@post)
        return redirect_to post_url(@post), :status => :moved_permanently
      end
    end
  end
end
