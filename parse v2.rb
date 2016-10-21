#require 'open-uri'
#download = open('http://physis.arch.tamu.edu/files/http_access_log')
#IO.copy_stream(download, 'log')

Dir.mkdir('monthly logs') unless File.exists?('monthly logs')
File.open('monthly logs/' + 'October 1994.txt', 'w+')
File.open('monthly logs/' + 'November 1994.txt', 'w+')
File.open('monthly logs/' + 'December 1994.txt', 'w+')
File.open('monthly logs/' + 'January 1995.txt', 'w+')
File.open('monthly logs/' + 'Febuary 1995.txt', 'w+')
File.open('monthly logs/' + 'March 1995.txt', 'w+')
File.open('monthly logs/' + 'April 1995.txt', 'w+')
File.open('monthly logs/' + 'May 1995.txt', 'w+')
File.open('monthly logs/' + 'June 1995.txt', 'w+')
File.open('monthly logs/' + 'July 1995.txt', 'w+')
File.open('monthly logs/' + 'August 1995.txt', 'w+')
File.open('monthly logs/' + 'September 1995.txt', 'w+')
File.open('monthly logs/' + 'October 1995.txt', 'w+')

log = File.open('log')

date_array = []
for line in log
  raw_date = line.scan(/\d{1,2}\/\S\S\S\/\d{4}/)
  date_array.push(raw_date)
end

date_str_array = []
for date_line in date_array
  for date in date_line
    date_str_array.push(date[3..11])
  end
end

date_hash = Hash.new(0)
error_hash = Hash.new(0)

for date_str in date_str_array
  date_hash.store(date_str, date_hash[date_str]+1)
end

for date_key,date_value in date_hash
  puts "On (#{date_key}) there were #{date_value} requests"
end

error_array = []
 
for error_line in log
  raw_error = error_line.scan(/([3-5]0[0-9])/)
  error_array.push(raw_error)
end
puts "#{error_array}"

for error_key,error_value in error_hash
  puts "On (#{error_key}) there were #{error_value} errors"
end
