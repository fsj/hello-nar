#!/usr/bin/env zsh
# Executes compiled executable with all dependencies in $LD_LIBRARY_PATH

# extract artifact name from POM and find the executable
local ARTIFACT=$(grep -m1 artifactId pom.xml |sed 's/^.*>\(.*\)<\/.*$/\1/')
local EXECUTABLE=$(ls target/nar/$ARTIFACT*executable/bin/*/$ARTIFACT)

# add all libraries in target to $LD_LIBRARY_PATH
local NARLIBS=''
for p in $(echo target/nar/**/*.so(:h) |sort -u); NARLIBS="$NARLIBS:$p"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH$NARLIBS"

# run the executable, passing on all arguments
exec $EXECUTABLE "$@"
