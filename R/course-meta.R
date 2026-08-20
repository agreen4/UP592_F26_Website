# ─────────────────────────────────────────────────────────────────────────────
# Course meta — SINGLE SOURCE OF TRUTH for when and where the seminar meets.
#
# Sourced by schedule.qmd, syllabus.qmd and index.qmd. Change it here only;
# the meeting day shown on the site is DERIVED from the start dates below, so
# a start date that is not a Friday will say so on the page rather than quietly
# disagreeing with the stated time.
# ─────────────────────────────────────────────────────────────────────────────

MEETING_TIME     <- "9:00&#8211;10:20 a.m."
MEETING_LOCATION <- "TBH 111 Conference Room"

FALL_START   <- as.Date("2026-08-28")   # Week 1, Fall 2026
SPRING_START <- as.Date("2027-01-22")   # Week 1, Spring 2027

# "Fridays, 9:00-10:20 a.m. · TBH 111 Conference Room"
meeting_line <- function(start) {
  sprintf("%ss, %s &#183; %s",
          format(start, "%A"), MEETING_TIME, MEETING_LOCATION)
}

# "August 28 - December 4, 2026"
date_span <- function(start, n) {
  last <- start + 7 * (n - 1)
  sprintf("%s &#8211; %s",
          trimws(format(start, "%B %e")),
          trimws(format(last, "%B %e, %Y")))
}

# Render date, for the "Last updated" stamp. Derived rather than typed: the
# hardcoded "July 2026" survived a full content rebuild and shipped stale.
# With `freeze: auto` this only moves when the page is actually re-rendered,
# which is the correct meaning of "last updated".
last_updated <- function() trimws(format(Sys.Date(), "%B %e, %Y"))
