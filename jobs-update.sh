#!/bin/sh
cat jobs/*.yml | jenkins-jobs --conf jenkins_jobs.ini update
