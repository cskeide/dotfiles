#!/bin/bash

if command -v walker >/dev/null 2>&1 && command -v elephant >/dev/null 2>&1; then
    echo "walker"
else
    echo "wofi"
fi