## usersテーブル

| Column     | Type       | Options                   |
| ---------- | ---------- | ------------------------- |
| nickname   | string     | null false, unique: true  |
| email      | string     | null false, unique: true  |
| password   | string     | null false, unique: true  |
| name       | string     | null false                |
| name_kana  | string     | null false                |
| birthday   | string     | null false                |

### Association
- has_many :items
- has_many :purchases


## itemsテーブル

| Column       | Type       | Options                       |
| ------------ | ---------- | ----------------------------- |
| image        |            | null false                    |
| item_name    | string     | null false                    |
| description  | text       | null false                    |
| category     | string     | null false                    |
| condition    | string     | null false                    |
| shipping_fee | string     | null false                    |
| area         | string     | null false                    |
| days         | string     | null false                    |
| price        | integer    | null false                    |
| user_id      | references | null false, foreign_key: true |


### Association
- belongs_to :user
- has_one :purchase



## commentsテーブル

| Column         | Type       | Options                       |
| -------------- | ---------- | ----------------------------- |
| purchaser      | string     | null false                    |
| purchased_item | string     | null false                    |
| user_id        | references | null false, foreign_key: true |
| item_id        | references | null false, foreign_key: true |

### Association
- belongs_to :user
- has_many :addresses



## addressesテーブル

| Column       | Type       | Options                       |
| ------------ | ---------- | ----------------------------- |
| postal_code  | string     | null false                    |
| prefectures  | string     | null false                    |
| municipality | string     | null false                    |
| house_number | string     | null false                    |
| building     | string     |                               |
| phone_number | string     | null false                    |
| purchase_id  | references | null false, foreign_key: true |

### Association
- belongs_to :purchase