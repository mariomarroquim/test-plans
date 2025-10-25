class ApplicationRecord < ActiveRecord::Base
  # Track all changes to models.
  has_paper_trail

  primary_abstract_class
end
