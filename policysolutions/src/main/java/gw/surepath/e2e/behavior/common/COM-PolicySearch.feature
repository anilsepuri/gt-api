@common @policy_search
Feature: Policy Search
  As a producer
  I want to be able to search for a policy
  So that I can review or update the policy

  Background:
    Given I am a user with the "Producer" role

  @DesignatedFunction
  Scenario: Search for a policy with policy number
    Given a Personal Auto policy
    When I search for that policy with policy number
    Then the policy is found

  @DesignatedFunction
  Scenario: Search for a policy by account
    Given a Personal Auto policy
    When I retrieve policies associated with the account
    Then the policy is found