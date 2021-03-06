#!/usr/bin/env bash

DEPS_LOCATION=deps
DESTINATION=boringssl

if [ -f "$DEPS_LOCATION/$DESTINATION/lib/libssl.a" ]; then
    echo "BoringSSL fork already exist. delete $DEPS_LOCATION/$DESTINATION for a fresh checkout."
    exit 0
fi

REPO=https://boringssl.googlesource.com/boringssl
BRANCH=chromium-stable
REV=3a667d10e94186fd503966f5638e134fe9fb4080

function fail_check
{
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        echo "error with $1" >&2
        exit 1
    fi
}

function DownloadBoringSsl()
{
	echo "repo=$REPO rev=$REV branch=$BRANCH"

	mkdir -p $DEPS_LOCATION
	pushd $DEPS_LOCATION

	if [ ! -d "$DESTINATION" ]; then
	    fail_check git clone -b $BRANCH $REPO $DESTINATION
    fi

	pushd $DESTINATION
	fail_check git checkout $REV
	popd
	popd
}

function BuildBoringSsl()
{
	pushd $DEPS_LOCATION
	pushd $DESTINATION

	mkdir build
	pushd build

	fail_check cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_FLAGS="-fPIC" -DCMAKE_CXX_FLAGS="-fPIC"
	fail_check make
	mkdir ../lib
	fail_check cp crypto/libcrypto.a ../lib/libcrypto.a
	fail_check cp ssl/libssl.a ../lib/libssl.a

    popd
	popd
	popd
}

DownloadBoringSsl
BuildBoringSsl
