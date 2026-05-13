class ApplicationController < ActionController::Base
  include Authentication

  # Track who changed models.
  before_action :set_paper_trail_whodunnit

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Invalidate caches when the app version changes.
  etag { APP_VERSION }
end
