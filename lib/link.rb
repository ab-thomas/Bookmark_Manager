class Link

  include DataMapper::Resource
  has n, :tags, :through => Resource


  property :id,     Serial # it will be auto-incremented for every record
  property :title,  String
  property :url,    String



end