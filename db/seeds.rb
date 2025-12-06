# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

unless User.exists?
  # Create admin user
  admin_user = User.create!(email_address: "admin@example.com") do |user|
    user.admin = true
    user.password = "password"
    user.password_confirmation = "password"
  end

  # CRM Test Plans
  test_plans_data = [
    {
      feature: "Client Management",
      use_case: "Create new client profile",
      steps_to_reproduce: "Navigate to Clients section\nClick Add New Client button\nFill in client details (name, email, phone, company)\nClick Save Client button. Verify client appears in client list"
    },
    {
      feature: "Client Management",
      use_case: "Edit existing client information",
      steps_to_reproduce: "Navigate to Clients section\nFind existing client in the list\nClick Edit button\nModify client information. Click Save Changes button\nVerify changes are reflected in client profile"
    },
    {
      feature: "Client Management",
      use_case: "Delete client profile",
      steps_to_reproduce: "Navigate to Clients section\nFind client to delete\nClick Delete button\nConfirm deletion in popup dialog. Verify client is removed from list"
    },
    {
      feature: "Contact Management",
      use_case: "Add contact to existing client",
      steps_to_reproduce: "Navigate to client profile\nClick Add Contact button\nFill in contact details (name, role, email, phone)\nClick Save Contact button. Verify contact appears in client contacts list"
    },
    {
      feature: "Contact Management",
      use_case: "Update contact information",
      steps_to_reproduce: "Navigate to client profile\nFind contact in contacts list\nClick Edit button\nModify contact information. Click Save Changes button\nVerify updated information is displayed"
    },
    {
      feature: "Lead Management",
      use_case: "Convert lead to client",
      steps_to_reproduce: "Navigate to Leads section\nFind qualified lead\nClick Convert to Client button\nFill in additional client details. Click Convert button\nVerify lead is moved to Clients section"
    },
    {
      feature: "Lead Management",
      use_case: "Qualify lead status",
      steps_to_reproduce: "Navigate to Leads section\nSelect lead from list\nClick Qualify Lead button\nSet qualification status (Hot, Warm, Cold). Add qualification notes\nClick Save button\nVerify status is updated in lead list"
    },
    {
      feature: "Deal Management",
      use_case: "Create new sales opportunity",
      steps_to_reproduce: "Navigate to Deals section\nClick New Deal button\nSelect associated client\nFill in deal details (value, close date, stage). Click Create Deal button\nVerify deal appears in deals pipeline"
    },
    {
      feature: "Deal Management",
      use_case: "Update deal stage",
      steps_to_reproduce: "Navigate to Deals section\nFind deal in pipeline\nClick Update Stage button\nSelect new stage from dropdown. Add stage notes\nClick Update button\nVerify deal moves to new stage"
    },
    {
      feature: "Deal Management",
      use_case: "Close won deal",
      steps_to_reproduce: "Navigate to Deals section\nFind deal in Proposal stage\nClick Close Deal button\nSelect Won status. Enter final deal value\nAdd closing notes\nClick Close Deal button\nVerify deal moves to Closed Won"
    },
    {
      feature: "Task Management",
      use_case: "Create follow-up task",
      steps_to_reproduce: "Navigate to Tasks section\nClick New Task button\nSelect associated client/deal\nSet task type (Call, Email, Meeting). Set due date and priority\nAdd task description\nClick Create Task button\nVerify task appears in task list"
    },
    {
      feature: "Task Management",
      use_case: "Mark task as completed",
      steps_to_reproduce: "Navigate to Tasks section\nFind pending task\nClick Mark Complete button\nAdd completion notes. Click Complete button\nVerify task status changes to completed"
    },
    {
      feature: "Communication History",
      use_case: "Log client interaction",
      steps_to_reproduce: "Navigate to client profile\nClick Log Interaction button\nSelect interaction type (Call, Email, Meeting)\nAdd interaction details and notes. Set interaction date\nClick Log Interaction button\nVerify interaction appears in history"
    },
    {
      feature: "Communication History",
      use_case: "View client communication timeline",
      steps_to_reproduce: "Navigate to client profile\nClick Communication History tab\nVerify all interactions are displayed\nCheck chronological order. Verify interaction details are complete"
    },
    {
      feature: "Reporting",
      use_case: "Generate sales pipeline report",
      steps_to_reproduce: "Navigate to Reports section\nClick Sales Pipeline report\nSelect date range\nChoose report format (PDF, Excel). Click Generate Report button\nVerify report contains correct deal data"
    },
    {
      feature: "Reporting",
      use_case: "Export client list",
      steps_to_reproduce: "Navigate to Clients section\nClick Export button\nSelect export format (CSV, Excel)\nChoose fields to include. Click Export button\nVerify exported file contains all client data"
    },
    {
      feature: "User Management",
      use_case: "Add new team member",
      steps_to_reproduce: "Navigate to Settings > Users\nClick Add User button\nFill in user details (name, email, role)\nSet user permissions. Click Create User button\nVerify user receives invitation email"
    },
    {
      feature: "User Management",
      use_case: "Assign client to team member",
      steps_to_reproduce: "Navigate to client profile\nClick Assign button\nSelect team member from dropdown\nAdd assignment notes. Click Assign button\nVerify client appears in team member dashboard"
    },
    {
      feature: "Data Import",
      use_case: "Import clients from CSV",
      steps_to_reproduce: "Navigate to Settings > Data Import\nClick Import Clients button\nUpload CSV file\nMap CSV columns to client fields. Preview import data\nClick Import button\nVerify clients are created successfully"
    },
    {
      feature: "Mobile App",
      use_case: "Access client data on mobile",
      steps_to_reproduce: "Open CRM mobile app\nLog in with credentials\nNavigate to Clients section\nSearch for specific client. View client details\nVerify all data displays correctly on mobile"
    }
  ]

  # Create test plans
  test_plans = test_plans_data.map do |plan_data|
    TestPlan.create!(
      user: admin_user,
      feature: plan_data[:feature],
    ) do |plan|
      plan.use_case = plan_data[:use_case]
      plan.steps_to_reproduce = plan_data[:steps_to_reproduce]
    end
  end

  # Generate random test runs for each test plan
  revisions = [ "1.0.0", "1.1.0", "1.2.0", "2.0.0", "2.1.0", "2.2.0", "3.0.0", "hotfix-001", "hotfix-002", "release-candidate-1" ]
  observations = [
    "All tests passed successfully. No issues found.",
    "Minor UI improvements needed for better user experience.",
    "Performance optimization required for large datasets.",
    "Integration with email system working correctly.",
    "Mobile responsiveness needs improvement.",
    "Data validation working as expected.",
    "User permissions functioning correctly.",
    "Report generation completed successfully.",
    "Import functionality working properly.",
    "Search feature performing well.",
    "Failed due to timeout issues with large datasets.",
    "Authentication flow needs refinement.",
    "Database connection issues resolved.",
    "API integration working correctly.",
    "User interface needs minor adjustments.",
    "Export functionality working as designed.",
    "Notification system functioning properly.",
    "Data synchronization completed successfully.",
    "Security measures implemented correctly.",
    "Cross-browser compatibility verified."
  ]

  test_plans.each do |test_plan|
    # Generate 1-4 random test runs per test plan
    rand(1..4).times do
      TestRun.create!(
        user: admin_user,
        test_plan: test_plan,
        revision: revisions.sample,
        passed: [ true, false ].sample,
        observations: observations.sample,
        created_at: rand(30.days).seconds.ago,
      )
    end
  end
end
