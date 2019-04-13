#!/bin/sh
set -eu

sh -c "git config --global user.name 'zrrrzzt' \
      && git config --global user.email 'geir.gasodden@pythonia.no' \
      && git commit -am '$*' --allow-empty \
      && git push -u origin master"