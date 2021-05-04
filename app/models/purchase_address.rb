class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :area_id, :municipality, :house_number, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :municipality
    validates :house_number
    validates :phone_number, format: { with: /\A[0-9]+\z/ }, length: { maximum: 11 }
    validates :token
  end

  validates :area_id, numericality: {other_than: 1}


  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, area_id: area_id, municipality: municipality, house_number: house_number, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end

end