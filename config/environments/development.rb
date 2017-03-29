Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Store emails as files (tmp/mails) instead of delivering them
  config.action_mailer.delivery_method = :file
  # Raise errors if emails can't be delivered
  config.action_mailer.raise_delivery_errors = true
  # Default rails server
  config.action_mailer.default_url_options = {host: 'localhost', port: 3000}
  # From email address
  config.action_mailer.default_options = {from: 'HPI WiMi Portal <hpi.wimiportal@localhost>'}

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # whitelist Vagrant Host IP
  # config.web_console.whitelisted_ips = '10.0.2.2'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.log_level = :warn

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  ## Raises an exception on encountering a missing translation
  ## than falling back to its default behavior
  config.action_view.raise_on_missing_translations = true
end
