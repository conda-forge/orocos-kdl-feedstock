#!/bin/sh

rm -rf build
mkdir build
cd build

PKG_NAME_ALIAS=${PKG_NAME//-/_}

cmake $SRC_DIR/$PKG_NAME_ALIAS \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=True \
    -DCMAKE_BUILD_TYPE=Release \
    -DCONDA_SP_DIR=$SP_DIR \
    -DPYTHON_EXECUTABLE=$PYTHON

cmake --build . --config Release --target install
