Simple Rack application.

The first, enter to console command `bundler install`, after enter `rackup` for run app.

Get current time with different formats.

Examples:
If current time equals 2021.10.22 10:35:56

Then enter URL http://localhost/time?format=year,month,day,hour,minute,second returned string 2021-10-22-10-35-56
Then enter URL http://localhost/time?format=year,month,day returned string 2021-10-22
Then enter URL http://localhost/time?format=hour,minute,second returned string 10-35-56
And etc.

If enter unknown time params or time formats, then returned message of errors.