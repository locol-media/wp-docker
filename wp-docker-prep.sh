#!/bin/bash

export DEV_SITE=/var/www/test-user-site/
export WP_SQL_USER=wordpress
export WP_SQL_HOST=localhost
export WP_SQL_DB=test_user_site

export WORK_DIR=work
cp -a ${DEV_SITE}. ${WORK_DIR}/tempwpfiles/

mysqldump -R -f --no-tablespaces -u ${WP_SQL_USER} -p --host ${WP_SQL_HOST} ${WP_SQL_DB} > ${WORK_DIR}/wp_${WP_SQL_DB}.sql