require 'spec_helper'

describe PasswordResetsController do

  after { ActionMailer::Base.deliveries.clear }

  describe 'POST create' do

    context "with valid input" do

      let(:user) { Fabricate(:user)}
      before do
        post :create, email: user.email
      end

      it "create user token" do
        expect(user.reload.token).to_not be_nil
      end

      it "redirect to confirm password reset" do
        expect(response).to redirect_to confirm_password_reset_path
      end

      context "send a mail" do

        it "" do
          expect(ActionMailer::Base.deliveries).to_not be_empty
        end

        it "with the correct address" do
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([user.email])
        end

        it "with a link that contain the user token" do
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to have_content(user.token)
        end
      end

    end

    context "with invalid input" do

      before do
        post :create, email: 'example@gmail.com'
      end

      it "render new template" do
        expect(response).to render_template :new
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end

    end
  end

  describe 'GET edit' do
    context "with valid input" do
      it "set the @user veriable" do
        user = Fabricate(:user)
        user.generate_token
        get :edit , token: user.reload.token
        expect(assigns[:user]).to eq(user)
      end
    end

    context "with invalid input" do
      it "redirect_to /front" do
        get :edit , token: 'kjhvkjvkjvkjj'
        expect(response).to redirect_to invalid_token_path
      end
    end
  end

  describe 'PATCH update' do

    let(:user) { Fabricate(:user) }
    before do
      user.generate_token
    end  

    context "with valid input" do

      before do
        patch :update, user_token: user.reload.token, password: "newpassword"
      end

      it "update the user password" do
        expect(user.reload.authenticate("newpassword")).to eq(user)
      end

      it "set notice message" do
        expect(flash[:notice]).to be_present
      end

      it "set user token to nil" do
        expect(user.reload.token).to be_nil
      end

      it "redirect to home page" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid input" do

      before do
        patch :update, user_token: user.reload.token, password: ""
      end

      it "set user veriable" do
        expect(assigns(:user)).to eq(user)
      end

      it "render edit" do
        expect(response).to render_template :edit
      end

      it "set error message" do
        expect(flash[:error]).to be_present
      end
    end
  end

end