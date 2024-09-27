#!/bin/sh

helm package .
helm repo index .

# tag it
# git add -A
# git commit -m "Release charts"
# git push