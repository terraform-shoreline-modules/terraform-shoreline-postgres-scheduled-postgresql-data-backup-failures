

#!/bin/bash



# Set the parameters

BACKUP_DIR=${BACKUP_LOCATION}

DAYS_TO_KEEP=7



# Clean up old backups

find $BACKUP_DIR -type f -mtime +$DAYS_TO_KEEP -delete



# Print a log message

echo "Old PostgreSQL backups cleaned up successfully."