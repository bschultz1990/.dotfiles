#!/bin/bash
sensors | awk '/^Package id 0:/ {sub(/^\+/, "CPU ",$4);print $4}'
sensors | awk '/^Left side/ {print $5 " " $4}'
