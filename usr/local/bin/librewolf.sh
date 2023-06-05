#!/bin/sh

if [ -n "${URL}" ]; then
	librewolf "${URL}"
else
	librewolf
fi
