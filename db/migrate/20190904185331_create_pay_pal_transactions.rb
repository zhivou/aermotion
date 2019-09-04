class CreatePayPalTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :pay_pal_transactions do |t|
      t.string :transaction_id
      t.string :string
      t.integer :local_user_id
      t.string :local_user_email
      t.string :method
      t.string :payer_id
      t.string :item
      t.decimal :price
      t.string :currency
      t.integer :quantity
      t.decimal :tax
      t.decimal :total
      t.string :paypal_created_time
      t.string :status

      t.timestamps
    end
  end
end
