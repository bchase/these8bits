.DEFAULT_GOAL := default
.PHONY: default
default:
	elm make src/Main.elm src/* --output dist/elm.js
