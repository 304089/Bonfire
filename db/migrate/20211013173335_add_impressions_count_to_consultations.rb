class AddImpressionsCountToConsultations < ActiveRecord::Migration[5.2]
  def change
    add_column :consultations, :impressions_count, :integer, default: 0
  end
end
