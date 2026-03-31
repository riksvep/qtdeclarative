#! /bin/bash

# Requirements (WIP)
# cmake
# gcc
# perl
# git

SRC_DIR=$(pwd)
WORKING_DIR=$(pwd)/work

# Build QT 6.10.1 static libraries
mkdir -p $WORKING_DIR
cd $WORKING_DIR


git clone https://code.qt.io/qt/qt5.git -b v6.10.1
cd qt5
perl ./init-repository --module-subset=qtbase,qtdeclarative
mkdir build
cd build
../configure -static -release -prefix $WORKING_DIR/qt5/build/install -nomake tests -nomake examples -no-opengl -no-gui -no-widgets -no-dbus -skip qt3d -skip qtimageformats -skip qtshadertools -skip qtwebengine -skip qtwebview -skip qtmultimedia -skip qtserialport -skip qtlocation -skip qtwayland -skip qttools -skip qttranslations -skip qtquickcontrols2
cmake --build . -j
cmake --install .

# Build qmlformat
cd $WORKING_DIR
#git clone https://github.com/qt/qtdeclarative.git -b v6.10.1
#cd qtdeclarative
cmake -GNinja \
  -DCMAKE_PREFIX_PATH=$WORKING_DIR/qt5/build/install/lib/cmake \
  -DBUILD_TESTING=OFF -S $SRC_DIR -Bbuild
cmake --build build --target qmlformat -j
strip build/bin/qmlformat
cp build/bin/qmlformat $WORKING_DIR