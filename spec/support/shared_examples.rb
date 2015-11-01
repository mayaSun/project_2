shared_examples "require_admin" do

  it "redirect to the home page" do
    clear_current_user
    set_current_user
    action
    expect(response).to redirect_to home_path
  end
    
end

shared_examples "require_user" do

  it "redirect to the home page" do
    clear_current_user
    action
    expect(response).to redirect_to home_path
  end
    
end

shared_examples "slugable" do

  it "set the slug" do
    object.generate_slug!
    expect(object.slug).to_not be_nil
  end

end

shared_examples "prev_next" do

  let!(:object2) {Fabricate(object_fabricator, name: 'adi')}
  let!(:object3) {Fabricate(object_fabricator, name: 'maya')}
  let!(:object1) {Fabricate(object_fabricator, name: 'aba')}
  let!(:object4) {Fabricate(object_fabricator, name: 'tidhar')}

  context "#prev" do
    it "return the previous object" do
      expect(object4.prev).to eq(object3)
      expect(object3.prev).to eq(object2)
      expect(object2.prev).to eq(object1)
    end

    it "return the last for the first object" do
      expect(object1.prev).to eq(object4)
    end
  end

  context "#next" do
    it "return the next object" do
      expect(object1.next).to eq(object2)
      expect(object2.next).to eq(object3)
      expect(object3.next).to eq(object4)
    end

    it "return the first for the last object" do
      expect(object4.next).to eq(object1)
    end
  end

end