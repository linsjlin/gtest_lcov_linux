#!/bin/bash
make clean
make -j12
./runTest
../lcov/bin/lcov -d ../../source/src/ -t 'runTest' -o 'runTest.info' -b . -c
../lcov/bin/genhtml runTest.info --quiet --output-directory lcov_output --title "runTest"
firefox ./lcov_output/index.html
