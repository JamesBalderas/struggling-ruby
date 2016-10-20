require 'open-uri'
download = open('http://physis.arch.tamu.edu/files/http_access_log')
IO.copy_stream(download, 'log')
