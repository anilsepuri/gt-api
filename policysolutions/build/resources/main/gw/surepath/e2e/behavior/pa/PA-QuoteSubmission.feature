@personal_auto
Feature: Submission Quoting
  As a producer
  I want to quote a submission
  So that I can determine the cost of the policy

  Background:
    Given I am a user with the "Producer" role
    And an account exists with the following details:
      | accountType  | state  |
      | Person       | CA     |

  @DesignatedFunction @draft_submission
  Scenario: Create a draft submission
    When I create a Personal Auto submission
    Then the submission is in "draft" status

  @DesignatedFunction @quote_submission
  Scenario: Creating a Quoted submission
    Given a draft Personal Auto Submission
    When I quote the Personal Auto submission
    Then the submission is in "quoted" status

  @DesignatedFunction @quote_submission
  Scenario: Payment info being determined after a submission is quoted
    Given a draft Personal Auto Submission
    When I quote the Personal Auto submission
    Then a Billing Method and Payment Plan are determined

  @DesignatedFunction @quote_submission @uw_issue
  Scenario: Cannot quote submission for a vehicle with an invalid VIN due to underwriting issue
    Given a draft Personal Auto Submission
    And a vehicle with a Vehicle Identification Number "FRE1234567"
    When I quote the Personal Auto submission with UW issue
    Then the submission cannot be quoted because of the UW issue

  @DesignatedFunction @quote_submission @validation_issue
  Scenario: Cannot quote a submission for a vehicle with no VIN due to validation
    Given a draft Personal Auto Submission
    And a vehicle without a Vehicle Identification Number
    When I quote the Personal Auto submission with validation issue
    Then the submission cannot be quoted because of the validation error