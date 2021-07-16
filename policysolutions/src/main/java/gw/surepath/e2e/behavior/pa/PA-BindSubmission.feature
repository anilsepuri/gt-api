@personal_auto
Feature: Submission Binding
  As a producer
  I want to bind a submission
  So that I can capture agreement that there is coverage

  Background:
    Given I am a user with the "Producer" role
    And an account exists with the following details:
      | accountType  | state  |
      | Person       | CA     |

  @DesignatedFunction @bind_submission
  Scenario: Creating a Bound submission
    Given a Quoted Personal Auto submission
    When I bind the submission
    Then the submission is in "bound" status

  @DesignatedFunction @issue_submission
  Scenario: Creating an Issued submission
    Given a Quoted Personal Auto submission
    When I issue the submission
    Then the submission is in "bound" status

  @DesignatedFunction @bind_submission
  Scenario: "Issue Policy" activity created when binding a submission
    Given a Quoted Personal Auto submission
    When I bind the submission
    Then an activity to "Issue Policy" is planned

  @DesignatedFunction @bind_submission
  Scenario: Generating policy number when binding a submission
    Given a Quoted Personal Auto submission
    When I bind the submission
    Then a policy number is set

  @DesignatedFunction @bind_submission @uw_issue
  Scenario: Checking Underwriting issues when binding submission
    Given a Quoted Personal Auto submission with a bind blocking UW issue
    When I bind the submission with UW issue
    Then the submission cannot be bound because of the UW issue