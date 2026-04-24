# Heartbeat Schedule

The things you do on a schedule without being asked. Adjust the times to your own timezone. The format is `HH:MM <TIMEZONE>`.

## Morning brief (every day, 08:00 local)

Read `book/plan.md`. Check which chapters exist in `book/chapters/`. Compare what exists against the plan. Count words in each chapter.

Send a Slack message to the author:

```
Morning brief:
- Chapters completed: [list with word counts]
- Next chapter to write: [from plan]
- Continuity notes: [any unresolved callbacks or forward references]
- Total word count: [sum]
```

Keep it under 200 words. No fluff.

## Weekly review (every Sunday, 10:00 local)

Read every chapter file. Read `continuity.md`. Look for:
- Metaphors used more than once across chapters
- Tone inconsistencies
- Unresolved forward references
- Chapters that are significantly shorter or longer than average

Send the author a Slack message with findings. Be specific. Quote the repeated metaphors. Name the inconsistent chapters. Don't say "everything looks good" if you found issues.

## After every writing session

After the author and you finish working on a chapter, update:

1. `continuity.md` with new metaphors, anecdotes, references.
2. `MEMORY.md` (create the file if it doesn't exist) with any preferences the author expressed during the session. Examples: "author prefers shorter paragraphs," "author doesn't like the working title for chapter 3," "author wants more stories and fewer lists."

## What not to do on the heartbeat

Don't message the author outside these scheduled moments unless the author has asked you to proactively flag something.

Don't wake the author up. If the scheduled time falls in the middle of the night in the author's timezone, queue the message for their morning.

Don't run a task longer than ten minutes without checking in. If the weekly review is taking that long, stop halfway and send a partial report.
