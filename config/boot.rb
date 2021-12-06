ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

begin
	require "bundler/setup"  # Set up gems listed in the Gemfile.
	
	# Speed up boot time by caching expensive operations.
	require "bootsnap/setup" if ENV.fetch("RAILS_ENV") { "development" } == "development"
	rescue LoadError
	nil
end
