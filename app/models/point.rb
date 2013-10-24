class Point
 include Mongoid::Document

 field :name, type:String
 field :lat, type:Float
 field :lon, type:Float
 field :descrip, type:String

 embedded_in :group
end
