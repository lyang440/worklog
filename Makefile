SHELL := /bin/bash

all:
	bower install
	npm install
	node_modules/.bin/gulp clean
	node_modules/.bin/gulp watch
	bower update horn -F

prod:
	bower install
	npm install
	node_modules/.bin/gulp clean
	node_modules/.bin/gulp prod
	bower update horn -F