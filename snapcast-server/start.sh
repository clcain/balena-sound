#!/usr/bin/env bash
  
#Exit service if client-only mode is enabled 
if [[ $CLIENT_ONLY_MULTI_ROOM == "1" ]]; then
  exit 0
fi
 
# snapcast-server disabled by default on Pi 1/2 family
if [[ $BALENA_DEVICE_TYPE == "raspberry-pi" || $BALENA_DEVICE_TYPE == "raspberry-pi2" ]]; then
  echo "Multi-room master server functionality is disabled by default on device types: Raspberry Pi (v1/Zero/Zero W) and Raspberry Pi 2."
  exit 0
fi

# Start snapserver if multi room is enabled
if [[ -z $DISABLE_MULTI_ROOM ]]; then
  /usr/bin/snapserver
else
  echo "Multi-room audio is disabled, not starting snapserver."
  exit 0
fi
