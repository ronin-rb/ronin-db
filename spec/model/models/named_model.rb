require 'ronin/db/model/has_name'

class NamedModel

  include Ronin::DB::Model::HasName

  property :id, Serial

end
