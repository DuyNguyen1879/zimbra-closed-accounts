#!/bin/bash
echo "Username Total Quota Usage Server Last Login Time"
zmaccts | grep closed | grep @ | awk '{ print $1 }' | while read ACCOUNT
do
QUOTA_TOTAL=`zmprov ga ${ACCOUNT} | grep "zimbraMailQuota" | cut -d ":" -f2`
QUOTA_USAGE=`zmmailbox -z -m ${ACCOUNT} gms`
HOSTED_ON=`zmprov ga ${ACCOUNT} | grep zimbraMailHost | awk -F: '{ print $2 }'`
LAST_ON=`zmprov ga ${ACCOUNT} | grep zimbraLastLogonTimestamp: | awk -F: '{ print $2 }' `
echo "${ACCOUNT} ${QUOTA_TOTAL} ${QUOTA_USAGE} ${HOSTED_ON} ${LAST_ON} "
done
