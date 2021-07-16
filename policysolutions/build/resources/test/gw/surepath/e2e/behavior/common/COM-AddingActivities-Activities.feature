@common @add_activity
Feature: Activity
  As a producer
  I want to add an activity to an account and policy
  So that I can track information to be aware of, decisions to be made, or work to be done

  Background:
    Given I am a user with the "Producer" role

  @DesignatedFunction
  Scenario: Adding an activity to an account
    Given a Personal account
    When I create an activity to "Review new mail" for the account
    Then the activity is in the account's workplan
    And the activity is assigned to me

  @DesignatedFunction
  Scenario: Adding an activity to a policy
    Given a Personal Auto policy
    When I create an activity to "Review new mail" for the policy
    Then the activity is in the policy's workplan
    And the activity is assigned to me