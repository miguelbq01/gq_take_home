class AddRedeemedToIncentives < ActiveRecord::Migration[6.0]
  def change
    add_column :incentives, :redeemed, :boolean, default: false
  end
end
