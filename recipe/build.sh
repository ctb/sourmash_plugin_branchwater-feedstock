#!/bin/bash

set -ex

# this breaks builds as of July 2024, but was required before then :) -- CTB.
#export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

export BINDGEN_EXTRA_CLANG_ARGS="$CFLAGS"
export LIBCLANG_PATH=$BUILD_PREFIX/lib/libclang${SHLIB_EXT}

maturin build --release --strip --manylinux off --interpreter="${PYTHON}" -m Cargo.toml

"${PYTHON}" -m pip install $SRC_DIR/target/wheels/*.whl --no-deps -vv

#cargo-bundle-licenses --format yaml --output THIRDPARTY.yml 
