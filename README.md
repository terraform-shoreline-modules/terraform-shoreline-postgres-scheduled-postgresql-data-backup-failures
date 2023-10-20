
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Scheduled PostgreSQL data backups failing.
---

This incident type refers to a situation where scheduled PostgreSQL data backups are not being performed successfully. This could be caused by a variety of reasons such as incorrect configuration, hardware or network issues, or software bugs. As a result, important data may not be backed up as expected, which could lead to data loss in case of a disaster or system failure.

### Parameters
```shell
export VERSION="PLACEHOLDER"

export BACKUP_SCRIPT="PLACEHOLDER"

export BACKUP_LOCATION="PLACEHOLDER"

export BACKUP_SERVER="PLACEHOLDER"

export BACKUP_PORT="PLACEHOLDER"
```

## Debug

### Check if PostgreSQL service is running
```shell
systemctl status postgresql
```

### Check PostgreSQL logs for any errors
```shell
tail -n 50 /var/log/postgresql/postgresql-${VERSION}.log
```

### Check the backup schedule configuration
```shell
cat /etc/cron.d/${BACKUP_SCRIPT}
```

### Check backup script logs for any errors
```shell
tail -n 50 /var/log/${BACKUP_SCRIPT}.log
```

### Check disk space on the backup location
```shell
df -h ${BACKUP_LOCATION}
```

### Check if backup server is reachable
```shell
nc -z ${BACKUP_SERVER} ${BACKUP_PORT}
```

## Repair

### Clean up the PostgreSQL backups more than a week old to free disk space
```shell


#!/bin/bash



# Set the parameters

BACKUP_DIR=${BACKUP_LOCATION}

DAYS_TO_KEEP=7



# Clean up old backups

find $BACKUP_DIR -type f -mtime +$DAYS_TO_KEEP -delete



# Print a log message

echo "Old PostgreSQL backups cleaned up successfully."


```