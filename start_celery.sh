#!/bin/bash
set -e
if [ ! -d /mnt/task_data/task_data ]; then
    echo "Task data is not mounted!"
    exit 1
fi
source /var/www/envs/twweb/bin/activate
export DJANGO_SETTINGS_MODULE=inthe_am.celery_settings
export NEW_RELIC_CONFIG_FILE=/var/www/twweb/newrelic-celery.ini
if [ -f $NEW_RELIC_CONFIG_FILE ]; then
    exec /var/www/envs/twweb/bin/newrelic-admin run-program /var/www/envs/twweb/bin/celery -A inthe_am.taskmanager.celery worker -l info
else
    exec /var/www/envs/twweb/bin/celery -A inthe_am.taskmanager.celery worker -l info
fi
