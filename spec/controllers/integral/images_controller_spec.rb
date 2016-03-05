require 'rails_helper'

module Integral
  describe ImagesController do
    routes { Integral::Engine.routes }
    let(:file) { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'images', 'person.jpg')) }
    let(:title) { 'foobar title' }
    let(:description) { Faker::Lorem.paragraph(8)[0..150] }
    let(:image_params) { { title: title, description: description, file: file } }
    let(:user) { create(:image_manager) }

    describe 'GET index' do
      context 'when not logged in' do
        it 'redirects to login page' do
          get :index

          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'when logged in' do
        before do
          sign_in user
        end

        context 'when user does not have required privileges' do
          let(:user) { create :user }

          before do
            get :index
          end

          it { expect(response.status).to eq 302 }
          it { expect(flash[:alert]).to eq I18n.t('errors.unauthorized') }
        end

        context 'when user has required privileges' do
          let(:images_sorted) { Image.all.order('created_at DESC') }

          before do
            expect(controller).to receive(:add_breadcrumb).with(I18n.t('integral.breadcrumbs.dashboard'), :root_path, {})
            expect(controller).to receive(:add_breadcrumb).with(I18n.t('integral.breadcrumbs.images'), :img_index_path, {})

            get :index
          end

          it { expect(response.status).to eq 200 }
          it { expect(response).to render_template 'index' }
          it { expect(assigns[:images]).to eq images_sorted }
        end
      end
    end

    describe 'POST create' do
      context 'when not logged in' do
        it 'redirects to login page' do
          post :create, image: image_params

          expect(response).to redirect_to new_user_session_path
        end
      end

      context 'when logged in' do
        before do
          sign_in user
        end

        context 'when user does not have required privileges' do
          let(:user) { create :user }

          before do
            post :create, image: image_params
          end

          it { expect(response.status).to eq 302 }
          it { expect(flash[:alert]).to eq I18n.t('errors.unauthorized') }
        end

        context 'when user has required privileges' do
          context 'when valid image params supplied' do
            it 'returns status created' do
              post :create, image: image_params

              expect(response.code).to eq "201"
              expect(response).to render_template 'integral/images/_card'
            end

            it 'saves a new image' do
              expect {
                post :create, image: image_params
              }.to change(Image, :count).by(1)
            end
          end

          context 'when invalid image params supplied' do
            it 'does not save a new image' do
              expect {
                post :create, image: image_params.merge!(title: '')
              }.not_to change(Image, :count)
            end

            it 'returns status unprocessable_entity' do
              post :create, image: image_params.merge!(title: '')

              expect(response.code).to eq "422"
            end
          end
        end
      end
    end

    describe 'GET new' do
      context 'when not logged in' do
        before { get :new }

        it { expect(response).to redirect_to new_user_session_path }
      end

      context 'when logged in' do
        before do
          sign_in user
        end

        context 'when user does not have required privileges' do
          let(:user) { create :user }

          before do
            get :new
          end

          it { expect(response.status).to eq 302 }
          it { expect(flash[:alert]).to eq I18n.t('errors.unauthorized') }
        end


        context 'when user has required privileges' do
          before do
            allow(Integral::Image).to receive(:new).and_return :foo
            expect(controller).to receive(:add_breadcrumb).with(I18n.t('integral.breadcrumbs.dashboard'), :root_path, {})
            expect(controller).to receive(:add_breadcrumb).with(I18n.t('integral.breadcrumbs.images'), :img_index_path, {})
            expect(controller).to receive(:add_breadcrumb).with(I18n.t('integral.breadcrumbs.new'), :new_img_path)

            get :new
          end

          it { expect(response.status).to eq 200 }
          it { expect(assigns(:image)).to eq :foo }
          it { expect(response).to render_template 'new' }
        end
      end
    end

    describe 'GET edit' do
      let(:image) { create(:image) }

      context 'when not logged in' do
        before { get :edit, id: image.id }

        it { expect(response).to redirect_to new_user_session_path }
      end

      context 'when logged in' do
        before do
          sign_in user
        end

        context 'when user does not have required privileges' do
          let(:user) { create :user }

          before do
            get :edit, id: image.id
          end

          it { expect(response.status).to eq 302 }
          it { expect(flash[:alert]).to eq I18n.t('errors.unauthorized') }
        end

        context 'when user has required privileges' do
          before do
            expect(controller).to receive(:add_breadcrumb).with(I18n.t('integral.breadcrumbs.dashboard'), :root_path, {})
            expect(controller).to receive(:add_breadcrumb).with(I18n.t('integral.breadcrumbs.images'), :img_index_path, {})
            expect(controller).to receive(:add_breadcrumb).with(I18n.t('integral.breadcrumbs.edit'), :edit_img_path)
            get :edit, id: image.id
          end

          it { expect(assigns[:image]).to eq image }
          it { expect(response).to render_template 'edit' }
        end
      end
    end

    describe 'PUT update' do
      let(:image) { create(:image) }

      context 'when not logged in' do
        before { put :update, id: image.id, image: image_params }

        it { expect(response).to redirect_to new_user_session_path }
      end

      context 'when logged in' do
        before do
          sign_in user
        end

        context 'when user does not have required privileges' do
          let(:user) { create :user }

          before do
            put :update, id: image.id, image: image_params
          end

          it { expect(response.status).to eq 302 }
          it { expect(flash[:alert]).to eq I18n.t('errors.unauthorized') }
        end

        context 'when user has required privileges' do
          before do
            put :update, id: image.id, image: image_params
            image.reload
          end

          context 'when valid parameters supplied' do
            it { expect(response).to redirect_to(img_index_path) }
            it { expect(flash[:notice]).to eq("Image successfully updated.") }
            it { expect(image.title).to eql title }
            it { expect(image.description).to eql description }
          end

          context 'when invalid parameters supplied' do
            let(:title) { '' }

            it { expect(image.title).not_to eql title }
            it { expect(image.description).not_to eql description }
            it { expect(response).to render_template 'edit' }
          end
        end
      end
    end

    describe 'DELETE destroy' do
      let(:image) { create(:image) }

      context 'when not logged in' do
        before { delete :destroy, id: image.id }

        it { expect(response).to redirect_to new_user_session_path }
      end

      context 'when logged in' do
        before do
          sign_in user
          delete :destroy, id: image.id
        end

        context 'when user does not have required privileges' do
          let(:user) { create :user }

          it { expect(response.status).to eq 302 }
          it { expect(flash[:alert]).to eq I18n.t('errors.unauthorized') }
        end

        context 'when user has required privileges' do
          it { expect { image.reload }.to raise_error(ActiveRecord::RecordNotFound) }
          it { expect(flash[:notice]).to eq("Image successfully deleted.") }
          it { expect(response).to redirect_to img_index_path }
        end
      end
    end
  end
end
