#!/bin/sh
# Haxe
rm -f haxe-build.zip
zip -r haxe-build.zip src LICENSE *.md *.json *.hxml

# Java
javac -cp src src/eci/*.java -d build/
jar -cf epicqr-release.jar build/*