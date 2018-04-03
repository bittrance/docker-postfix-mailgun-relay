#!/bin/sh

# Set timezone
if [ ! -z "${SYSTEM_TIMEZONE}" ]; then
    echo "configuring system timezone"
    echo "${SYSTEM_TIMEZONE}" > /etc/timezone
    dpkg-reconfigure -f noninteractive tzdata
fi

# Set mynetworks for postfix relay
if [ ! -z "${MYNETWORKS}" ]; then
    echo "setting mynetworks = ${MYNETWORKS}"
    postconf -e mynetworks="${MYNETWORKS}"
fi

# Set mydestination
if [ ! -z "${MYDESTINATION}" ]; then
    ORIG_MYDESTINATION=$(postconf -h mydestination)
    echo "original mydestination = ${ORIG_MYDESTINATION}"
    echo "setting mydestination = ${MYDESTINATION}"
    postconf -e mydestination="${ORIG_MYDESTINATION}, ${MYDESTINATION}"
fi

# General the email/password hash and remove evidence.
if [ ! -z "${EMAIL}" ] && [ ! -z "${EMAILPASS}" ]; then
    echo "[smtp.mailgun.org]:2525    ${EMAIL}:${EMAILPASS}" > /etc/postfix/sasl_passwd
    postmap /etc/postfix/sasl_passwd
    rm /etc/postfix/sasl_passwd
    echo "postfix EMAIL/EMAILPASS combo is setup."
else
    echo "EMAIL or EMAILPASS not set!"
fi
unset EMAIL
unset EMAILPASS
