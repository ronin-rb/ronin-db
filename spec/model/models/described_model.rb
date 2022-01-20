require 'ronin/db/model/has_description'

class DescribedModel

  include Ronin::DB::Model::HasDescription

  property :id, Serial

end
