#!/bin/bash

## Define the base path of the observatory environment.
base_env_home=/home/obs_user
## Define the list of shared packages.
declare -a base_env_packages="ts_observatory_control ts_observing_utilities ts_standardscripts ts_externalscripts summit_utils summit_extras"


## This function defines the repository reset steps.
function reset_repo() {
    git reset --hard && git clean -fxd
}


## This function resets the repo to the latest release (tagged) version of the package.
function checkout_release() {
    curr_dir=$(basename $(pwd)) #returns the base directory name.
    if [[ ! "$base_env_packages" =~ "${curr_dir}" ]]; then #if not a base_env_package, do nothing. 
        echo "This is NOT a base environment package."
    else
        reset_repo && source ${base_env_home}/cycle.env && git checkout v${!curr_dir}
    fi
}


## Do the rollback.
if [ -z $1 ]; then #reset a single repository.
    checkout_release
elif [ "$1" == "all" ]; then #reset all base_env_packages
    for repo in $base_env_packages
    do
        cd ${base_env_home}/repos/${repo}
        checkout_release
    done
else
    echo "Something went wrong"
fi
