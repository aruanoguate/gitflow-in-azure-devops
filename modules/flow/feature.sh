#!/bin/bash

git checkout develop
git pull origin develop
git branch feature-$1 develop
git checkout feature-$1
git push -u origin feature-$1