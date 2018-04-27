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

namespace local_hide_inactive_courses\task;

defined('MOODLE_INTERNAL') || die();
require_once($CFG->dirroot. '/course/lib.php');
use stdClass;

/**
 * Scheduled task (cron task) that checks all courses, and if they haven't been accessed within the time limit, hides them.
 */
class hide_courses extends \core\task\scheduled_task {

    public function get_name() {
        return get_string('hide_courses_task', 'local_hide_inactive_courses');
    }

    public function execute() {
        global $DB, $CFG;

        if ($CFG->local_hide_inactive_courses_onoff) {
            $courses = $DB->get_records_select(
              'course',
              'id > 1'
            );
            foreach ($courses as $course) {
                $limit = $CFG->local_hide_inactive_courses_limit;
                $t = time() - $limit;

                $sql = "SELECT ac.*";
                $sql .= " FROM {user_lastaccess} ac";
                $sql .= " JOIN {course} c ON ac.courseid=c.id";
                $sql .= " JOIN {enrol} e ON c.id=e.courseid";
                $sql .= " JOIN {user_enrolments} ue ON e.id=ue.enrolid";
                $sql .= " JOIN {user} u ON u.id=ue.userid";
                $sql .= " WHERE c.id=$course->id";
                $sql .= " AND ac.timeaccess > $t";
                $sql .= " AND ac.userid=u.id";
                $accesses = $DB->get_records_sql($sql);

                if (count($accesses) == 0) {
                    // Hide course.
                    course_change_visibility($course->id, false);

                    // If email is turned off, abort.
                    if (! $CFG->local_hide_inactive_courses_email_onoff) {
                        return;
                    }

                    // Email any instructors.
                    // Find users with Teacher role.
                    $context = $DB->get_record('context', array('instanceid' => $course->id, 'contextlevel' => 50));
                    $role_assignments = $DB->get_records(
                        'role_assignments',
                        array(
                            'contextid' => $context->id,
                            'roleid' => 3
                        )
                    );

                    // If there are teachers, build an email and send it to each of them.
                    if (count($role_assignments) > 0) {
                        $noreplyuser = \core_user::get_noreply_user();
                        $from = new stdClass();
                        $from->customheaders = 'Auto-Submitted: auto-generated';
                        $from->maildisplay = true; // Required to prevent Notice.
                        $from->email = $noreplyuser->email; // Required to prevent Notice.

                        // Get email content.
                        $message = $CFG->local_hide_inactive_courses_email_content;

                        // Get subject.
                        $subject = array();
                        preg_match("/\{SUBJECT: (.*)\}\s+/", $message, $subject);

                        // For each instructor, customize and send the email.
                        foreach ($role_assignments as $roleassignment) {
                            // Establish patterns and replaces.
                            $recipient = $DB->get_record('user', array('id' => $roleassignment->userid));
                            $replace = array(
                                '/\{RECIPIENT\}/' => fullname($recipient),
                                '/\{COURSE\}/' => $course->fullname,
                                '/\{SUBJECT: (.*)\}\s+/' => '',
                            );

                            // Replace patterns in both subject and content.
                            $subject = preg_replace(array_keys($replace), array_values($replace), $subject[1]);
                            $message = preg_replace(array_keys($replace), array_values($replace), $message);

                            // Send.
                            email_to_user($recipient, $from, $subject, $message);
                        }
                    }
                }
            }
        }
    }
}
