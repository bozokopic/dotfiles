#!/bin/sh

killall -q polybar
polybar -q bar1 &
polybar -q bar2 &
