require 'spec_helper'

describe ContactUsController do

  after { ActionMailer::Base.deliveries.clear }

  describe 'POST create' do
    context "with valid input" do
      
      before do
        post :create, subject: "Hello", name: "Bar Refaeli",email: "barrefaeli@gmail.com" ,message: "having fun here"
      end

      it "set the notice message" do
        expect(flash[:notice]).to be_present
      end
      
      it "redirect to home path" do
        expect(response).to redirect_to home_path
      end

      it "sends out e-mail" do
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends out e-mail for the correct address" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(["holylandherbs@gmail.com"])
      end

      it "sends out e-mail with the message" do
        expect(ActionMailer::Base.deliveries.last.body).to have_content('having fun here')
      end
    end


    context "with invalid input" do

      before do
        params = {}
        params[:name] = 'Bar Refaeli'
        params[:email] = 'BarRefaeli@gmail.com'
        params[:subject] = "love ya"
        params[:message] = 'Hello.. nice to be in this amazing website!!'
        params[[:name,:email,:message,:subject].sample] = [nil, ""].sample
        post :create, params
      end

      it "set the error message" do
        expect(flash[:error]).to be_present
      end

      it "does not send email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end