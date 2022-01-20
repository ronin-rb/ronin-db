require 'ronin/db/model/model'

class BaseModel

  include Ronin::DB::Model

  property :id, Serial

  property :name, String

  property :age, Integer

end
