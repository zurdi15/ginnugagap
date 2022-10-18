#!/bin/env bash

sudo apt update
[[ -z $(which python3) ]] && sudo apt install python3 -y
[[ -z $(which pip3) ]] && sudo apt install python3-pip -y
yes | python3 -m pip install --user ansible