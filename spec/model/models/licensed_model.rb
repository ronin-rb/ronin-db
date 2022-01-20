require 'ronin/db/model/has_license'

class LicensedModel

  include Ronin::DB::Model::HasLicense

  property :id, Serial

  property :content, String

end
