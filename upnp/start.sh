#!/usr/bin/env bash
 
#Exit service if client-only mode is enabled 
if [[ $CLIENT_ONLY_MULTI_ROOM == "1" ]]; then
  exit 0
fi

#Exit service if DISABLE_UPNP is enabled
if [[ $DISABLE_UPNP == "1" ]]; then
  exit 0
fi

if [[ -z "$DEVICE_NAME" ]]; then
  DEVICE_NAME=$(printf "balenaSound UPnP %s" $(hostname | cut -c -4))
fi

# If multi room is disabled remove audio redirect to fifo pipe
# Also remove if device is from Pi 1/2 family, since snapcast server is disabled by default
if [[ -n $DISABLE_MULTI_ROOM ]] || [[ $BALENA_DEVICE_TYPE == "raspberry-pi" || $BALENA_DEVICE_TYPE == "raspberry-pi2" ]]; then
  rm /root/.asoundrc
fi

exec /usr/bin/gmediarender -f "$DEVICE_NAME" --port=49494
