module PrevNext
  extend ActiveSupport::Concern

  def prev
    self.class.order(:name).where("name < ?", self.name).last || self.class.order(:name).last
  end

  def next
    self.class.order(:name).where("name > ?", self.name).first || self.class.order(:name).first
  end

end