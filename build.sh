#!/bin/bash
set -e

./prepare.sh

./buildbook.sh
./buildeval.sh