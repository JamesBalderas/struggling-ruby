require_relative 'download'
require 'date'
require 'open-uri'

# File Options
ONLINE_FILE = 'http://physis.arch.tamu.edu/files/http_access_log'
THIS_FILE = 'http_access_log.bak'
LOG_FILE = 'logs/'

# My Variables
i = 0
sums = {}
by_month= {}
request = {}
errors = []

# Get File
print "\n\nDownloading log file from URI... "
download = open(ONLINE_URL)
IO.copy_stream(download, THIS_FILE)
puts "File retrieved and saved to disk (#{THIS_FILE}) \n\n"

# Loop through each line of the file
File.foreach(THIS_FILE) do |line|
	 end

	pattern = /.*\[(.*) .*\] "(A-Z]{3,4}) (.*) .*" (\d{3}) .*.match(line)

	if !pattern then
		errors.push(line)
		next
	end

	# Grab the data from the fields we care about
	date(ft) = Date.strptime(pattern[1], '%d/%b/%Y:%H:%M:%S')
	mon_year = req_date.strftime('%Y-%m')
	verb = pattern[2]
	type = pattern[3]
	sc = pattern[4]

	# Add the file name to the hash if not there; increment otherwise
	files[file_name] = (if files[file_name] then files[file_name]+=1 else 1 end)

	# Add the status code to the hash if not there; increment otherwise
	counts[stat_code] = (if counts[stat_code] then counts[stat_code]+=1 else 1 end)

	# Check if we're on a new date; if so, add a new array to the hash
	unless sums[mon_year] then sums[mon_year] = [] end

	# Add the whole line into the array for that day
	sum[mon_year].push(line)

end
puts "\n\n"

# Sort the hash with file request counts to find the highest (and lowest)
classify_files = by_month.sort_by { |k, v| -v }

# Calculate a grand total by adding the counts from each month
#   Also, write the lines out to per-month log entries`
final_total = 0
Dir.mkdir(LOG_PATH) unless File.exists?(LOG_FILE)
sums.each do |key, arr|
	final_total += arr.count
	type = LOG_FILE + key + '.log'
	File.open(type, "w+") do |f|
		f.puts(arr)
	end
	puts "  Writing new file to disk: #{type} (#{arr.count} entries)"
end

# Sum all the status codes to get the totals
tally_3xx = 0
tally_4xx = 0
tally_5xx = 0
counts.each do |code, count|
	if code[0] == "3" then tally_3xx += count end
	if code[0] == "4" then tally_4xx += count end
	if code[0] == "5" then tally_5xx += count end
end
error = (tally_4xx.to_f / final_total.to_f * 100).to_i
redirect = (tally_3xx.to_f / final_total.to_f * 100).to_i

# Write the errors to a log file
File.open("error.log", "w+") do |f|
	f.puts(errors)
end

# Write all the data out to the screen
puts "\n\n\n"
puts "--- STATS ---"
puts "Total Request: #{final_total}"
puts "Requests per month: "
sum.each do |mon, lines|
	puts "    #{mon}: #{lines.count}"
end
puts "Average requests per month: #{final_total / total.count}"
puts "Commonly requested: #{classify_files[0]}"
puts "Least requested : #{classify_files[classify_files.count-1]}"
puts "Errors: #{error}% (#{tally_4xx} total)"
puts "Redirects: #{redirect}% (#{tally_3xx} total)"

puts "\n\n--- ERRORS ---"
puts "Encountered parsing errors on #{errors.count} lines."
puts "  Output written to error.log \n\n"
