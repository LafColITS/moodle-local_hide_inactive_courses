@local @local_hide_inactive_courses
Feature: Hide Inactive Courses

  @javascript
  Scenario: Testing automatic hiding of inactive courses
    Given the following "courses" exist:
      | fullname    | shortname   | numsections |
      | Test Course | testcourse  | 44          |
    Given the following "users" exist:
      | username  | firstname | lastname |
      | testadmin | Test      | Admin    |
      | testuser  | Test      | User     |
    When I log in as "admin"
    And I am on site homepage
    And I follow "Test Course"
    And I follow "Participants"
    And I enrol "testuser" user as "Teacher"
    When I log in as "testadmin"
    And I am on site homepage
    And I follow "Test Course"
    When I log in as "teacher"
    And I am on site homepage
    And I follow "Test Course"
    When I log in as "admin"
    And I am on site homepage
    And I trigger cron
    And I navigate to ??
