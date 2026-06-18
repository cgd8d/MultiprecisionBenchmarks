#!/bin/sh

set -eux

cat /proc/cpuinfo

mkdir -p bin

sudo apt-get install libbenchmark-dev

DIALECT_FLAGS="-std=c++17 -ffp-contract=off -fno-math-errno"

GCC_WARNING_FLAGS="-Wall -Wextra -Wpedantic -pedantic-errors -Wshadow \
    -Wconversion -Warith-conversion -Wdouble-promotion \
    -Wcast-qual -Wuseless-cast -Winit-self -Wlogical-op \
    -Wformat=2 -Wstrict-overflow=2 -Wdisabled-optimization -Winline"

CLANG_WARNING_FLAGS="-Weverything -Wno-float-equal -Wno-c++98-compat-pedantic \
    -Wno-unsafe-buffer-usage -Wno-global-constructors -Wno-alloca"

OPTIMIZATION_FLAGS="-O3 -march=native -flto \
    -fvisibility=hidden -fmerge-all-constants"

clang++-20 $DIALECT_FLAGS $CLANG_WARNING_FLAGS $OPTIMIZATION_FLAGS \
    -isystem./include -I./common \
    multifloats/main.cpp -lbenchmark -lbenchmark_main \
    -o bin/MultiFloatsBenchmarkClang
