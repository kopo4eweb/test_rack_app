class TimePage

  attr_accessor :status, :headers
  attr_reader :body

  attr_accessor :unknown_args

  def initialize
    @status = 200
    @headers = { 'Content-Type' => 'text/plain' }
    @body = ['']

    @unknown_args = []
  end

  def body=(val)
    @body = ["#{val}\n"]
  end

  def call(env)
    run(env)
    [status, headers, body]
  end

  private

  def run(env)
    req = Rack::Request.new env
    req_params = req.params

    if req_params.has_key?('format')
      self.status = 200      
      list_args = parse_format(req_params["format"])
      array_time_format = build_time_string(list_args)
      self.body = get_time(time_array_to_str(array_time_format)) if validate?
    else
      self.status = 400
      self.body = "In request do no contain the parameter 'format'"
    end
  end

  def parse_format(args)
    args.split(',')
  end

  def build_time_string(list_args)
    array_time_format = []

    list_args.each do |arg|
      case arg
      when 'year'
        array_time_format << '%Y'
      when 'month'
        array_time_format << '%m'
      when 'day'
        array_time_format << '%d'
      when 'hour'
        array_time_format << '%H'
      when 'minute'
        array_time_format << '%M'
      when 'second'
        array_time_format << '%S'
      else
        self.unknown_args << arg
      end
    end

    array_time_format
  end

  def validate?
    if unknown_args.length > 0
      self.status = 400
      self.body = "Unknown time format [#{unknown_args.join(', ')}]"
      self.unknown_args = []
      return false
    end

    true
  end

  def time_array_to_str(array_time_format)
    array_time_format.join('-')
  end

  def get_time(time_string)
    Time.now.strftime(time_string)
  end
end