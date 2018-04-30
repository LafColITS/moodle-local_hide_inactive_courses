@local @local_hide_inactive_courses
Feature: Hide Inactive Courses

  @javascript
  Scenario: Has been visited by enrolled user
    Given the following "courses" exist:
      | fullname        | shortname      | numsections | id |
      | Inactive Course | inactivecourse | 44          | 23 |
      | Active Course   | activecourse   | 44          | 24 |
    Given the following "users" exist:
      | username     | firstname | lastname |
      | testadmin    | Test      | Admin    |
      | testteacher  | Test      | Teacher  |
      | teststudent  | Test      | Student  |
    When I log in as "admin"
    And I am on site homepage
    And I follow "Active Course"
    And I follow "Participants"
    And I enrol "testteacher" user as "Teacher"
    And I enrol "teststudent" user as "Student"
    And I am on site homepage
    And I follow "Inactive Course"
    And I follow "Participants"
    And I enrol "testteacher" user as "Teacher"
    And I enrol "teststudent" user as "Student"
    And I log out

    When I log in as "testadmin"
    And I am on site homepage
    And I follow "Active Course"
    And I am on site homepage
    And I follow "Inactive Course"
    And I log out
    When I log in as "testteacher"
    And I am on site homepage
    And I follow "Active Course"
    And I am on site homepage
    And I follow "Inactive Course"
    And I log out
    When I log in as "teststudent"
    And I am on site homepage
    And I follow "Active Course"
    And I am on site homepage
    And I follow "Inactive Course"
    And I log out

    When I log in as "admin"
    And I trigger cron
    And I am on site homepage
    And I log out

    When I log in as "testteacher"
    And I am on site homepage
    Then I should see "Inactive Course"
    And I should see "Active Course"
    And I log out
    When I log in as "teststudent"
    And I am on site homepage
    Then I should see "Inactive Course"
    And I should see "Active Course"

  @javascript
  Scenario: Has not been visited by enrolled user
    Given the following "courses" exist:
      | fullname        | shortname      | numsections | id |
      | Inactive Course | inactivecourse | 44          | 23 |
      | Active Course   | activecourse   | 44          | 24 |
    Given the following "users" exist:
      | username     | firstname | lastname |
      | testadmin    | Test      | Admin    |
      | testteacher  | Test      | Teacher  |
      | teststudent  | Test      | Student  |
    When I log in as "admin"
    And I am on site homepage
    And I follow "Active Course"
    And I follow "Participants"
    And I enrol "testteacher" user as "Teacher"
    And I enrol "teststudent" user as "Student"
    And I am on site homepage
    And I follow "Inactive Course"
    And I follow "Participants"
    And I enrol "testteacher" user as "Teacher"
    And I enrol "teststudent" user as "Student"
    And I log out

    When I log in as "testadmin"
    And I am on site homepage
    And I follow "Active Course"
    And I am on site homepage
    And I follow "Inactive Course"
    And I log out
    When I log in as "testteacher"
    And I am on site homepage
    And I follow "Active Course"
    And I am on site homepage
    And I should see "Inactive Course"
    And I log out
    When I log in as "teststudent"
    And I am on site homepage
    And I follow "Active Course"
    And I am on site homepage
    And I should see "Inactive Course"
    And I log out

    When I log in as "admin"
    And I trigger cron
    And I am on site homepage
    And I log out

    When I log in as "testteacher"
    And I am on site homepage
    Then I should see "Inactive Course"
    And I should see "Active Course"
    And I log out
    When I log in as "teststudent"
    And I am on site homepage
    Then I should not see "Inactive Course"
    And I should see "Active Course"

  @javascript
  Scenario: Plugin is off
    Given the following "courses" exist:
      | fullname        | shortname      | numsections | id |
      | Inactive Course | inactivecourse | 44          | 23 |
      | Active Course   | activecourse   | 44          | 24 |
    Given the following "users" exist:
      | username     | firstname | lastname |
      | testadmin    | Test      | Admin    |
      | testteacher  | Test      | Teacher  |
      | teststudent  | Test      | Student  |
    When I log in as "admin"
    And I am on site homepage
    And I navigate to "Hide Inactive Courses" node in "Site administration>Plugins>Local plugins"
    And I click on "s__local_hide_inactive_courses_onoff" "checkbox"
    And I press "Save changes"
    And I am on site homepage
    And I follow "Active Course"
    And I follow "Participants"
    And I enrol "testteacher" user as "Teacher"
    And I enrol "teststudent" user as "Student"
    And I am on site homepage
    And I follow "Inactive Course"
    And I follow "Participants"
    And I enrol "testteacher" user as "Teacher"
    And I enrol "teststudent" user as "Student"
    And I log out

    When I log in as "testadmin"
    And I am on site homepage
    And I follow "Active Course"
    And I am on site homepage
    And I follow "Inactive Course"
    And I log out
    When I log in as "testteacher"
    And I am on site homepage
    And I follow "Active Course"
    And I am on site homepage
    And I should see "Inactive Course"
    And I log out
    When I log in as "teststudent"
    And I am on site homepage
    And I follow "Active Course"
    And I am on site homepage
    And I should see "Inactive Course"
    And I log out

    When I log in as "admin"
    And I trigger cron
    And I am on site homepage
    And I log out

    When I log in as "testteacher"
    And I am on site homepage
    Then I should see "Inactive Course"
    And I should see "Active Course"
    And I log out
    When I log in as "teststudent"
    And I am on site homepage
    Then I should see "Inactive Course"
    And I should see "Active Course"
