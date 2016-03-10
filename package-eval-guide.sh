#!/bin/bash

# zip up eval guide for easy download into nexus-bundles

cd target/
zip -r sonatype-nexus-eval-guide.zip sonatype-nexus-eval-guide.*

