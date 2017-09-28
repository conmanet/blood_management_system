class Serializers::HistorySerializer < ActiveModel::Serializer
  attributes :id, :user_id, :place_id, :date, :created_at, :is_verified,
    :donation_type, :platelet_count, :referer, :patient_name
  has_one :place
end
