#!/bin/sh
rm -f library.zip
zip -r library.zip src LICENSE *.md *.json *.hxml
haxelib submit library.zip $(pass show Dev/lib.haxe.org) --always