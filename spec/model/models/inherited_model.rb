require 'ronin/db/model/model'
require_relative 'base_model'

class InheritedModel < BaseModel

  include Ronin::DB::Model

  attr_reader :var

  def initialize(attributes={})
    super(attributes)

    @var = 2
  end

end
