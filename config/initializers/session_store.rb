# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_njl_session',
  :secret      => 'e6f5f3ae73814e92331718e95f618df9ce2fc88b337d1b0fc6cfd0be578bcfde7221c3513ec8ba54d704ac14443edb371750f8e5d7a81dc0b1a6a535e3619aca'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
