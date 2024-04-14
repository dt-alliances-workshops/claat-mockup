#/bin/bash

gulp clean
rm -rf codelabs-gen/
gulp dist
gulp serve
