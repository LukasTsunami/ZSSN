Everett.configure do |config|
  # Activate observers that should always be running.
  config.observers = :survivor_infection_observer
end
