class AddErrorToPayPalTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :pay_pal_transactions, :error, :text
  end
end
