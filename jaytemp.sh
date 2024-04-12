#/bin/bash

gulp clean
rm -rf codelabs-gen/
gulp serve:dist
