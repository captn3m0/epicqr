#!/bin/bash

## Tests for Java
javac -cp src/ test/Test.java
java -enableassertions -cp src:test Test