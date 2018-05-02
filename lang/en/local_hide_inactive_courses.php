<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Version details.
 *
 * @package    local_hide_inactive_courses
 * @copyright  2018 onwards Lafayette College ITS
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

$string['email_content_desc'] = 'Email content';
$string['email_content_subdesc'] = 'Content of the email to be sent to instructors of auto hidden courses';
$string['email_content_default'] = "{SUBJECT: {COURSE} has been automatically hidden due to inactivity}

Dear {RECIPIENT},

Your course '{COURSE}' has been set to hidden because no users have accessed it for a long time. Please contact the help desk for more information.";
$string['email_onoff_desc'] = 'Send email alerts';
$string['email_onoff_subdesc'] = 'Whether or not to send email alerts to course instructors if their course is auto-hidden';
$string['hide_courses_task'] = 'Hide inactive courses';
$string['limit_desc'] = 'Access time limit';
$string['limit_subdesc'] = 'How long ago must the last course access have been for it to be considered inactive?';
$string['pluginname'] = 'Hide inactive courses';
