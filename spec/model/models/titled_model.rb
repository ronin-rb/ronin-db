require 'ronin/db/model/has_title'

class TitledModel

  include Ronin::DB::Model::HasTitle

  property :id, Serial

end
