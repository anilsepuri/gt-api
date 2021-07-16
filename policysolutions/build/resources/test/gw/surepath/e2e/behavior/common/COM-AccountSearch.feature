@common @account_search
Feature: Account Search
  As a producer
  I want to search for an account
  So that I can review or update the account and associated policies

  Background:
   Given I am a user with the "Producer" role

  @DesignatedFunction
  Scenario: Search for an account with account holder's name
    Given a Personal account
    When I search for that account with the account holder's first and last name
    Then the account is found
    And verify.match(