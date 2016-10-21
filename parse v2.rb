#Note: Andrew Lara significantly contributed to this project. Like a lot. extra points for him pls.
require 'open-uri'
download = open('http://physis.arch.tamu.edu/files/http_access_log')
IO.copy_stream(download, 'log')

Dir.mkdir('monthly logs/') unless File.exists?('monthly logs/')
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

count = 0
for line_count in log
  count +=1
end

puts "There were #{count} requests in the log file. \n"

#-------------------------------------------------------------------
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

for date_str in date_str_array
  date_hash.store(date_str, date_hash[date_str]+1)
end

for date_key,date_value in date_hash
  puts "On (#{date_key}) there were #{date_value} requests."
end
#-----------------------------------------------------------------------
log = File.open('log')

def get_month(line)
  raw_month_get = line.scan(/\d{1,2}\/\S\S\S\/\d{4}/)
  for raw_month_s in raw_month_get
    month_and_year = raw_month_s[3..5] + raw_month_s[7..11]
    return month_and_year
  end
end

for eachline in log
  if get_month(eachline) == "Oct/1994"
    File.open('monthly logs/' + 'October 1994.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Nov/1994"
    File.open('monthly logs/' + 'November 1994.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Dec/1994"
    File.open('monthly logs/' + 'December 1994.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Jan/1995"
    File.open('monthly logs/' + 'January 1995.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Feb/1995"
    File.open('monthly logs/' + 'Febuary 1995.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Mar/1995"
    File.open('monthly logs/' + 'March 1995.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Apr/1995"
    File.open('monthly logs/' + 'April 1995.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "May/1995"
    File.open('monthly logs/' + 'May 1995.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Jun/1995"
    File.open('monthly logs/' + 'June 1995.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Jul/1995"
    File.open('monthly logs/' + 'July 1995.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Aug/1995"
    File.open('monthly logs/' + 'August 1995.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Sep/1995"
    File.open('monthly logs/' + 'September 1995.txt', 'a') {|f| f.write(eachline)}
  elsif get_month(eachline) == "Oct/1995"
    File.open('monthly logs/' + 'October 1995.txt', 'a') {|f| f.write(eachline)}
  end
end

#------------------------------------------------------------------------

log = File.open('log')
code_line_array = []
for codeline in log
  raw_code = codeline.scan(/".*"\W(\d{3})/)
  for raw_code_line in raw_code
    code_line_array.push(raw_code_line)
  end
end

code_array = []

for code_str in code_line_array
  for code in code_str
    code_array.push(code)
  end
end

fail_count = 0
redir_count = 0
tot_count = 0


for i in code_array
  tot_count += 1.0
  if i[0] == "4"
    fail_count += 1
  elsif i[0] == "3"
    redir_count += 1
  end
end


fail_percent = (fail_count/tot_count) * 100
redir_percent = (redir_count/tot_count) * 100

puts "%Fails = #{(fail_percent).round(2)} %Redirects = #{(redir_percent).round(2)} \n"

#-------------------------------------------------------------------------------------

log = File.open('log')
mostfile = []
for fileline in log
  raw_file_get = fileline.scan(/[G][E][T]\W([^\s]+)/)
  for raw_file_line in raw_file_get
    mostfile.push(raw_file_line)
  end
end

file_array = []

for filestring in mostfile
  for file in filestring
    file_array.push(file)
  end
end

file_names = Hash.new(0)

for filex in file_array
  file_names.store(filex, file_names[filex]+1)
end

puts "The most requested file was #{file_names.key(file_names.values.max)}\n"
puts "The least requested file was #{file_names.key(file_names.values.min)}\n"
