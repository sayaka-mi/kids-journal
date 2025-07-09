# README

## users

|Column            |Type    |Options                    |
|------------------|--------|---------------------------|
|id                |integer |null:false,primary_key:true|
|email             |string  |null:false,unique:true     |
|encrypted_password|string  |null:false                 |
|name              |string  |null:false                 |
|created_at        |datetime|null:false                 |
|updated_at        |datetime|null:false                 |

### Association
- has_many :children
- has_many :records, through: :children
- has_many :shared_users, class_name: 'SharedUser', foreign_key: 'user_id'

## children
|Column      |Type    |Options                     |
|------------|--------|----------------------------|
|id          |integer |null:false, primary_key:true|
|user_id     |integer |null:false, foreign_key:true|
|name        |string  |null:false                  |
|birthday    |date    |null:false                  |
|gender      |integer |null:false                  |
|allergy_info|text    |                            |
|blood_type  |string  |                            |
|created_at  |datetime|null:false                  |
|updated_at  |datetime|null:false                  |

### Association
- belongs_to :user
- has_many :records
- has_many :vaccination_records
- has_many :height_weights

## records
|Column    |Type    |Options                     |
|----------|--------|----------------------------|
|id        |integer |null:false, primary_key:true|
|child_id  |integer |null:false, foreign_key:true|
|content   |text    |                            |
|image     |string  |ActiveStorage使用           |
|created_at|datetime|null:false                  |
|updated_at|datetime|null:false                  |

### Association
- belongs_to :child
- has_many :record_tags
- has_many :tags, through: :record_tags

## tags
|Column    |Type    |Options                     |
|----------|--------|----------------------------|
|id        |integer |null:false, primary_key:true|
|name      |string  |null:false, unique:true     |
|created_at|datetime|null:false                  |
|updated_at|datetime|null:false                  |

### Association
- has_many :record_tags
- has_many :records, through: :record_tags

## record_tags
|Column    |Type    |Options                     |
|----------|--------|----------------------------|
|id        |integer |null:false, primary_key:true|
|record_id |integer |null:false, foreign_key:true|
|tag_id    |integer |null:false, foreign_key:true|
|created_at|datetime|null:false                  |
|updated_at|datetime|null:false                  |

### Association
- belongs_to :record
- belongs_to :tag

## height_weights
|Column     |Type    |Options                     |
|-----------|--------|----------------------------|
|id         |integer |null:false, primary_key:true|
|child_id   |integer |null:false, foreign_key:true|
|height     |float   |                            |
|weight     |float   |                            |
|recorded_at|datetime|null:false                  |
|created_at |datetime|null:false                  |
|updated_at |datetime|null:false                  |

### Association
- belongs_to :child

## vaccination_records
|Column            |Type    |Options                     |
|------------------|--------|----------------------------|
|id                |integer |null:false, primary_key:true|
|child_id          |integer |null:false, foreign_key:true|
|vaccine_id        |integer |null:false, ActiveHash使用  |
|other_vaccine_name|string  |                            |
|hospital_name     |string  |                            |
|memo              |text    |                            |
|scheduled_date    |date    |null:false                  |
|completed         |boolean |null:false, default:false   |
|vaccinated_at     |date    |                            |
|created_at        |datetime|null:false                  |
|updated_at        |datetime|null:false                  |


### Association
- belongs_to :child

## shared_users
|Column        |Type    |Options                     |
|--------------|--------|----------------------------|
|id            |integer |null:false, primary_key:true|
|user_id       |integer |null:false, foreign_key:true|
|shared_user_id|integer |null:false, foreign_key:true|
|created_at    |datetime|null:false                  |
|updated_at    |datetime|null:false                  |


### Association
- belongs_to :user
- belongs_to :shared_user, class_name: 'User', foreign_key: 'shared_user_id'

