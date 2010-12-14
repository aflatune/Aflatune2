# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Aflatune::Application.initialize!

require File.expand_path('../../lib/melc/melc', __FILE__)
VERIFY_TOKEN = "ppakoobecaftsebeht"
