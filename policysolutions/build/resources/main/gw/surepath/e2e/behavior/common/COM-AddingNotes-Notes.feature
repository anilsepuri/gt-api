@common @add_note
Feature: Note
  As an producer
  I want to be able to add a note to an account or policy
  So that I can capture information and track their progress

  Background:
    Given I am a user with the "Producer" role

  @DesignatedFunction
  Scenario: Adding a note to an account
    Given a Personal account
    Then I can add a note to the account with the following:
      | topic   | body                         |
      | general | Account is in pending status |

  @DesignatedFunction
  Scenario: Adding a note to a policy
    Given a Personal Auto policy
    Then I can add a note to the policy with the following:
      | topic    | body                                                                |
      | coverage | Requested if out of country coverage would be included in PA policy |