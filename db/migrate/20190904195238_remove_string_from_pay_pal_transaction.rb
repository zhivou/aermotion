class RemoveStringFromPayPalTransaction < ActiveRecord::Migration[6.0]
  def change
    remove_column :pay_pal_transactions, :string, :string
  end
end
