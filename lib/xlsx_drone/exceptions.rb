# Exceptions defs.
module XLSXDrone

  # Errors caused by the user because of doing something invalid or not allowed.
  module UserError

    # May happen on xlsx_load_sheet().
    class IndexOutOfBounds < RuntimeError; end

    # May happen on xlsx_load_sheet().
    class NonExistent < RuntimeError; end
  end

  # Errors caused by the system itself.
  module LogicError

    # Errors on the library itself.
    module InternalError

      # May happen on xlsx_open().
      class CantDeployFile < RuntimeError; end

      # May happen on xlsx_open(), xlsx_load_sheet().
      class XMLParsingError < RuntimeError; end
    end

    # Caused because of wrong use of the library.
    module ClientError

      # May happen on xlsx_load_sheet().
      class MalformedParams < RuntimeError; end
    end
  end

  # Something is flooded or temporary offline, usually the user is suggested to try later.
  module TransientFailure

  end
end