# docker-postfix-mailgun-relay
A docker image that uses postfix as a relay through Mailgun. Useful to link to other images.

## Configurables

```
SYSTEM_TIMEZONE = UTC or America/New_York
MYNETWORKS = "10.0.0.0/8 192.168.0.0/16 172.0.0.0/8"
EMAIL = postmaster@example.com (as shown in Mailgun web UI)
EMAILPASS = password (as shown in Mailgun web UI)
```

## Example

```bash
docker run -i -t --rm \                                                        
    --name mailgun-relay \
    -p 9025:25 \
    -e SYSTEM_TIMEZONE="America/New_York" \
    -e MYNETWORKS="10.0.0.0/8 192.168.0.0/16 172.0.0.0/8" \                    
    -e EMAIL="postmaster@example.com" \
    -e EMAILPASS="your_password" \
    postfix-mailgun-relay
```
