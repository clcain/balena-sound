#!/usr/bin/env bash

# Start snapclient if multi room is enabled
if [[ -z $DISABLE_MULTI_ROOM ]]; then
  # Wait for fleet-supervisor to start up
  # We need this because fleet-supervisor depends on resin_supervisor, which has no support for depends_on
  if [[ -z $SNAPCAST_SERVER ]]; then
    while ! curl -s "http://localhost:3000"; do sleep 1; done
  fi

  # Add latency if defined to compensate for speaker hardware sync issues
  if [[ -n $DEVICE_LATENCY ]]; then
    LATENCY="--latency $DEVICE_LATENCY"
  fi

  # Start snapclient
  if [[ -z $SNAPCAST_SERVER ]]; then
    SNAPCAST_SERVER=$(curl --silent http://localhost:3000)
  fi
  echo -e "Starting snapclient...\nTarget snapcast server: $SNAPCAST_SERVER"
  /usr/bin/snapclient -h $SNAPCAST_SERVER $LATENCY
else
  echo "Multi-room audio is disabled, not starting snapclient."
  exit 0
fi
