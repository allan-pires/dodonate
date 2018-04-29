describe UsersController do

  describe "#update" do
    before do
      post :update, :user => { name: "Adalberto", email: "adalberto@gmail.com", password: "minhasenha" }
    end

    context "sucessfully" do
      it { expect(response).to redirect_to(user) }
      it { expect(flash[:success]).to be_present }
    end

    context "failed" do
      it { expect(response).to render_template(edit_path) }
      it { expect(flash[:error]).to be_present }
    end
  end

end