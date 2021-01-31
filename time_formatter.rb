class TimeFormatter

  TIME_ARGS = { year: '%Y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%S' }

  def call(time_string)
    Time.now.strftime(time_string)
  end

  class << self
    def checking_args(args)
      build_time_string(parse_format(args))
    end

    private
    
    def parse_format(args)
      args.split(',')
    end

    def build_time_string(list_args)
      array_time_format = []
      unknown_args = []

      list_args.each do |arg|
        if TIME_ARGS.has_key?(arg.to_sym)
          array_time_format << TIME_ARGS[arg.to_sym]
        else
          unknown_args << arg
        end
      end

      return { correсt: array_time_format.join('-') } if unknown_args.length.zero?

      { unknown: unknown_args.join(', ') }
    end
  end
end