require 'ronin/db/model/has_version'

class VersionedModel

  include Ronin::DB::Model::HasVersion

  property :id, Serial

  property :content, String

end
