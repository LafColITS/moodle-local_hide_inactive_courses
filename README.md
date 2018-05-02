# Moodle Local Hide Inactive Courses

This plugin runs a cron task which automatically hides any courses which have not been accessed for a configurable time period. It also sends an email alert to any Teachers in a course when it is auto-hidden.

## Settings

You can configure the following aspects of the plugin:
- Whether it is active
- The time limit for course inactivity, i.e., how long ago the last course access must have been for the course to count as inactive (default 1 year)
- Whether or not to send email alerts to teachers in auto-hidden courses
- The content of email alerts, including dynamic replacement flags (see default email content for example)

## Details

- The plugin only counts course accesses from users who are enrolled in the course
- The cron task starts as disabled; therefore, to enable plugin functionality, you must go to Site adminisration > Server > Scheduled tasks, and enable the task titled "Hide inactive courses"
- The cron task is set to run once every day by default
