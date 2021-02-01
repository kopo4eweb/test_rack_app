class TimeFormatter

  TIME_ARGS = { year: '%Y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%S' }

  attr_accessor :args, :time_string
  attr_reader :invalid_params

  def initialize(args)
    @args = args

    @time_string = ''
    @invalid_params = ''
  end

  def call
    checking_args
    self.time_string = Time.now.strftime(time_string)
  end
  
  def success?
    return true if invalid_params.empty?
    false
  end

  def invalid_params=(val)
    @invalid_params = "Unknown time format [#{val}]" unless val.empty?
  end

  private
  
  def checking_args
    build_time_string(parse_format(args))
  end

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

    self.time_string = array_time_format.join('-')
    self.invalid_params = unknown_args.join(', ')
  end
  
end