#!/bin/sh
# Haxe
rm -f haxe-build.zip
zip -r haxe-build.zip src LICENSE *.md *.json *.hxml

# Java
# TODO: Directly generate JAR from haxe
javac -cp src src/eci/*.java -d build/
jar -cf epicqr-release.jar build/*

# PHP
haxe _targets/php.hxml
sed -i '/^use/d' src/eci/*.php
sed -i '/^Boot::/d' src/eci/*.php

# Node.js
haxe _targets/nodejs.hxml