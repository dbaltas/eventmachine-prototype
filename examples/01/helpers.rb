
def log(what)
	puts "[#{Time.now}]: #{what}\n"
end

def log_header(what)
	log "----------------------------------"
	log what
	log "----------------------------------"
end
