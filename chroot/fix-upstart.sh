#!/bin/bash

dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

