require "rails_helper"

RSpec.describe "Messages", type: :request do
  describe "POST /messages" do
    context "with valid params" do
      it "creates a message and redirects to dashboard" do
        post messages_path, params: {
          message: {
            category: "sports",
            body: "Hello world"
          }
        }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)

        message = Message.last
        expect(message.category).to eq("sports")
        expect(message.body).to eq("Hello world")

        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid params" do
      it "does not create a message and re-renders the form" do
        expect {
          post messages_path, params: {
            message: {
              category: "sports",
              body: "   "
            }
          }
        }.not_to change(Message, :count)

        expect(response).to have_http_status(:unprocessable_entity)

        expect(response.body).to include("Body")
      end
    end
  end
end
