class Item < ApplicationRecord

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price, format: {with: /\A[0-9]+\z/}, numericality: { in: 300..9999999 }

    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :fee_id
      validates :area_id
      validates :days_id
    end
    
  end

  belongs_to :user
  has_one_attached :image


  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to :category
  belongs_to :condition
  belongs_to :fee
  belongs_to :area
  belongs_to :days

end
