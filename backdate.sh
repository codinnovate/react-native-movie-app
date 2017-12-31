#!/bin/bash

# Start date: January 1st, 2018
START_DATE="2018-01-01"

# Number of days you want to backdate commits for (30 days in this case)
DAYS=30

# Create commits for the first 30 days of 2018
for i in $(seq 0 $((DAYS - 1))); do
    # Calculate the date for each commit
    COMMIT_DATE=$(date -d "$START_DATE +$i days" +"%Y-%m-%dT%H:%M:%S")

    # Set the commit author and committer date to the calculated date
    GIT_AUTHOR_DATE="$COMMIT_DATE" GIT_COMMITTER_DATE="$COMMIT_DATE" git commit --amend --no-edit --date "$COMMIT_DATE"

    # Optionally, modify a file (ensure there are changes for each commit)
    echo "Commit for $COMMIT_DATE" > file.txt
    git add file.txt

    # Commit with the backdated timestamp
    git commit -m "Commit on $COMMIT_DATE"

    # Push after each commit (you can push all at once after the loop if preferred)
    git push origin main
done
