class AddReportToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :report, :boolean , default: false
    add_column :picks, :bookie, :string
  end
end
