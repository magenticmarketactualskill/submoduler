# frozen_string_literal: true

# Dependencies will be loaded when needed by specific commands
# For now, the master gem can work independently

require_relative 'submoduler_master/cli'
require_relative 'submoduler_master/init_command'
require_relative 'submoduler_master/validate_command'

module SubmodulerMaster
  VERSION = '0.1.0'
end
