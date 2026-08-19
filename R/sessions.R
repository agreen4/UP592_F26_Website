# ─────────────────────────────────────────────────────────────────────────────
# Session definitions — SINGLE SOURCE OF TRUTH for what happens each week.
#
# Sourced by schedule.qmd (renders the tables) and index.qmd (derives the
# "at a glance" counts). Keeping the counts derived means a session added or
# removed here cannot leave a stale "5 rounds of peer presentations" on the
# homepage — the exact defect that shipped on the UP 591 site.
#
# Dates are NOT here: they come from the start dates in R/course-meta.R, in
# order, one week apart. Row order IS the schedule.
# ─────────────────────────────────────────────────────────────────────────────

s <- function(type, topic, lead) {
  data.frame(Type = type, Topic = topic, Lead = lead,
             stringsAsFactors = FALSE)
}

fall_sessions <- rbind(
  s("Workshop",     "Welcome, Agenda Setting &amp; Annual CV Check-In",     "Andrew"),
  s("Workshop",     "From Seminar Paper to Journal Article",                "Andrew"),
  s("Presentation", "Peer Research Presentations (Round 1)",                "All Students"),
  s("Workshop",     "Targeting the Right Journal",                          "Andrew"),
  s("Presentation", "Peer Research Presentations (Round 2)",                "All Students"),
  s("Workshop",     "ACSP Prep: Abstracts, Posters, Conference Strategy",   "Andrew"),
  s("Break",        "ACSP Conference (Pittsburgh, Oct 8&#8211;10)",         "&mdash;"),
  s("Workshop",     "Crafting an Argument and Contribution",                "Andrew"),
  s("Presentation", "Peer Research Presentations (Round 3)",                "All Students"),
  s("Workshop",     "Responding to Peer Review",                            "Andrew"),
  s("Presentation", "Peer Research Presentations (Round 4)",                "All Students"),
  s("Workshop",     "Co-authorship and Collaboration",                      "Andrew"),
  s("Student",      "TBD: Student-Initiated Session",                       "Students"),
  s("Break",        "Thanksgiving Break",                                   "&mdash;"),
  s("Synthesis",    "Semester Reflection &amp; Spring Preview",             "All")
)

spring_sessions <- rbind(
  s("Workshop",   "Welcome Back &amp; Spring Agenda Setting",               "Andrew"),
  s("Workshop",   "Proposal Structure &amp; Qualifying Packet / Exam",      "Andrew"),
  s("Milestone",  "Plan of Study Presentation (First-Year)",                "Cohort B"),
  s("Workshop",   "Theoretical Framework Development",                      "Andrew"),
  s("Milestone",  "Updated Plan of Study &amp; Annotated Bibliography",     "Cohort A"),
  s("Workshop",   "Methods Alignment and Justification",                    "Andrew"),
  s("Milestone",  "Qualifying Packet / Exam Content (Student 1)",           "Cohort A"),
  s("Workshop",   "Timeline, Feasibility &amp; Risk Management",            "Andrew"),
  s("Break",      "Spring Break",                                           "&mdash;"),
  s("Milestone",  "Qualifying Packet / Exam Content (Student 2)",           "Cohort A"),
  s("Workshop",   "Defending Your Work: Mock Defense / Exam Strategies",    "Andrew"),
  s("Conference", "ICUA/UAA Presentation Practice",                         "Students"),
  s("Break",      "ICUA/UAA Conference (New York, Apr 14&#8211;16)",        "&mdash;"),
  s("Student",    "TBD: Student-Initiated Session",                         "Students"),
  s("Synthesis",  "End of Year Celebration",                                "All")
)

# Count sessions of a given type, for prose that would otherwise go stale
n_type <- function(sessions, type) sum(sessions$Type == type)

# Week number of the first session whose Topic matches a pattern
week_of <- function(sessions, pattern) {
  which(grepl(pattern, sessions$Topic, fixed = TRUE))[1]
}
