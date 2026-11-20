#!/bin/sh

rm -rf build
mkdir build
cd build

PKG_NAME_ALIAS=${PKG_NAME//-/_}

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" == "1" && "${PKG_NAME}" == "python-orocos-kdl" ]]; then
  # FindPython only searches $PREFIX for headers when cross-compiling; point it there
  PY_INC=$PREFIX/include/python${PY_VER}
  CMAKE_ARGS="${CMAKE_ARGS} -DPython3_INCLUDE_DIR=${PY_INC} -DPython_INCLUDE_DIR=${PY_INC}"
fi

cmake ${CMAKE_ARGS} $SRC_DIR/$PKG_NAME_ALIAS \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=True \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DSETUPTOOLS_DEB_LAYOUT=OFF \
    -DPYTHON_SITE_PACKAGES_INSTALL_DIR=$SP_DIR \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DPython_EXECUTABLE=$PYTHON \
    -DPython3_EXECUTABLE=$PYTHON

cmake --build . --config Release --target install
