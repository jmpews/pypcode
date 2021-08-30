#!/bin/bash
set -e
set -x

if [ ! -d "./ghidra_src"]; then
  git clone --depth=1 -b Ghidra_10.0.2_build https://github.com/NationalSecurityAgency/ghidra.git ghidra_src
fi

# We just need Makefile and $(LIBSLA_SOURCE) defined inside Makefile. Do it this
# way to make sure we stay up to date with the list of required files.
SLEIGH_SRC_DIR=sleigh
pushd ghidra_src/Ghidra/Features/Decompiler/src/decompile/cpp/
mkdir -p $SLEIGH_SRC_DIR
cp xml.cc space.cc float.cc address.cc pcoderaw.cc translate.cc opcodes.cc globalcontext.cc sleigh.cc pcodeparse.cc pcodecompile.cc sleighbase.cc slghsymbol.cc slghpatexpress.cc slghpattern.cc semantics.cc context.cc filemanage.cc loadimage.cc sleigh.cc memstate.cc emulate.cc opbehavior.cc xml.hh space.hh float.hh address.hh pcoderaw.hh translate.hh opcodes.hh globalcontext.hh sleigh.hh pcodeparse.hh pcodecompile.hh sleighbase.hh slghsymbol.hh slghpatexpress.hh slghpattern.hh semantics.hh context.hh filemanage.hh loadimage.hh sleigh.hh memstate.hh emulate.hh opbehavior.hh slgh_compile.cc slghparse.cc slghscan.cc slgh_compile.hh slghparse.hh types.h partmap.hh error.hh slghparse.y pcodeparse.y xml.y slghscan.l loadimage_bfd.hh loadimage_bfd.cc Makefile \
  ./$SLEIGH_SRC_DIR/
popd

rm -rf ./native/${SLEIGH_SRC_DIR}
cp -r ghidra_src/Ghidra/Features/Decompiler/src/decompile/cpp/${SLEIGH_SRC_DIR} ./native/${SLEIGH_SRC_DIR}
cp -r ghidra_src/Ghidra/Processors ./processors
