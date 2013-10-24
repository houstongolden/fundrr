class Group
 include Mongoid::Document

 field :name, type:String
 field :descrip, type:String

 has_and_belongs_to_many :gusers, class_name:"User", inverse_of: :ugroups
 embeds_many :point

end
