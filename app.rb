require_relative 'time_formatter'

class App

  def call(env)
    req = Rack::Request.new env

    if is_time_page?(req)
      checking_params(req)
    else
      response(404, 'Page not found')
    end
  end

  private

  def is_time_page?(req)
    req.path == '/time'
  end

  def checking_params(req)
    params = req.params

    if params.has_key?('format')
      checking_args(params['format'])
    else
      response(400, "In request do no contain the parameter 'format'")
    end
  end

  def checking_args(args)
    tf = TimeFormatter.new(args)
    tf.call

    if tf.success?
      response(200, tf.time_string)
    else
      response(400, tf.invalid_params)
    end
  end

  def response(status, body)
    Rack::Response.new(body, status, { 'Content-Type' => 'text/plain' }).finish
  end
end