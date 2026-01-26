#!/usr/bin/env bash
# Fetch weather from wttr.in and output JSON for Waybar
curl -s "wttr.in/?format=j1" | jq -r '
  {
    text: ("🌦️ " + (.current_condition[0].temp_C) + "°C"),
    tooltip: ("Feels: " + .current_condition[0].FeelsLikeC + "°C")
  } | @json
'
