Feature: Signing in
  Scenario: Unsuccessful signin
    Given a user visits the signin page
    When he submit invalid signin information
    Then he should shee an error message

  Scenario: Succesful signin
    Given a user visits the signin page
      And the user has an account
      And the user submits valid signin information
    Then he should see his profile page
      And he should see a signout link
