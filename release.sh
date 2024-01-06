#!/bin/sh
# Haxe
rm -f haxe-build.zip
zip -r haxe-build.zip src LICENSE *.md *.json *.hxml
haxelib submit haxe-build.zip $(pass show Dev/lib.haxe.org) --always
rm -f haxe-build.zip

# Java
javac -cp src src/eci/*.java -d build/
jar -cf epicqr-release.jar build/*