require "./callbacks"
require "./fields"
require "./querying"
require "./settings"
require "./table"
require "./transactions"
require "./version"

# Granite::ORM::Base is the base class for your model objects.
class Granite::ORM::Base
  include Settings
  include Callbacks
  include Fields
  include Table
  include Transactions

  extend Querying

  macro inherited
    include Kemalyst::Validators

    macro finished
      __process
    end
  end

  macro __process
    __process_table
    __process_fields
    __process_querying
    __process_transactions
  end

  def initialize(**args : Object)
    set_attributes(args.to_h)
  end

  def initialize(args : Hash(Symbol | String, DB::Any))
    set_attributes(args)
  end

  def initialize
  end
end