#!/bin/sh

set -xe
source ../ci-lib.sh

# 1) Pull source and gen build environment
gen_build_dir_with_git 'https://github.com/intel/torch-ccl'
setup_build_env

# FIXME need to checkout c27ded5 or create a patch because the repo version.txt is messed up
# git checkout c27ded5

# 2) Set torch-ccl build configuration
export ONECCL_BINDINGS_FOR_PYTORCH_BACKEND='xpu'
export INTELONEAPIROOT="$ONEAPI_ROOT"
export USE_SYSTEM_ONECCL='ON'
export COMPUTE_BACKEND='dpcpp'

# 3) Build
build_bdist_wheel 'torch-ccl'

# 4) Cleanup
archive_artifacts 'torch-ccl'
cleanup_build_dir
