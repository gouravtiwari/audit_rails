module AuditRails
  module DBExtension
    def adapter_type
      connection.adapter_name.downcase.to_sym
    end

    def hourly(column)
      case adapter_type
      when :mysql, :mysql2
        "hour(#{column})"
      when :sqlite, :sqlite3
        "strftime('%H', #{column})"
      when :postgresql
        "DATE_PART('hour', #{column})"
      else
        raise NotImplementedError, "Unknown adapter type '#{adapter_type}'"
      end
    end
  end
end
