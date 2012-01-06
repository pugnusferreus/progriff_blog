#!/bin/sh

jekyll
rsync -rc _site/ ../progriff.com/site
