#!/usr/bin/env bash

killall -q polybar
polybar -q bar1 &
polybar -q bar2 &
