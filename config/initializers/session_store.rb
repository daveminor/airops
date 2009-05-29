# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_airops_session',
  :secret      => '30a2d027b0f3ebe00c72afa0d0450bee50e614acfe699bafd97325cf3c9a208ae83f682b1e9cae1ecc621bb2e5f381c527e0454018fad2d48430f5880e46bf23'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
