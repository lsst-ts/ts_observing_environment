#!/bin/bash

[ -f ~/notebooks/.user_setup ] && mv ~/notebooks/.user_setup ~/notebooks/.user_setup.$(date '+%Y%m%d_%H%M%S').bkup
touch ~/notebooks/.user_setup
