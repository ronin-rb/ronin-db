require 'ronin/db/model/has_authors'

class AuthoredModel

  include Ronin::DB::Model::HasAuthors

  property :id, Serial

  property :content, String

end
