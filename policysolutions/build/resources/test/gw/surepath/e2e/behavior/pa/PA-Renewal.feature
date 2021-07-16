@personal_auto @renewal
Feature: Renewal
  As a producer
  I want to identify policies due for renewal
  So that I can efficiently retain policyholders

  Background:
    Given I am a user with the "Producer" role

  @DesignatedFunction
  Scenario: Start renewal within lead time
    Given a Personal Auto policy with expiration date within the renewal lead time
    When policies are checked for renewal
    Then a renewal is started