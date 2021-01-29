require_relative 'time_page'

map '/time' do
  run TimePage.new
end

run lambda { |env| [404, {'Content-Type' => 'text/plain'}, ["Page not found.\n"]] }
