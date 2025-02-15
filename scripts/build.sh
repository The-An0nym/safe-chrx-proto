#!/bin/bash

set -e
# running inside chrxer repo directory root

WRK=$(realpath $(dirname $(dirname "$0")))
DEPOT="$WRK/depot_tools"
CHROMIUM="$WRK/chromium"
VERSION=$(cat "$WRK/chromium.version")

export PATH="$DEPOT:$PATH"

echo "Configuring ccache"
ccache --max-size=30G
export CCACHE_CPP2=yes
export CCACHE_SLOPPINESS=time_macros

# Build Chromium
cd "$CHROMIUM/src"

# https://salsa.debian.org/chromium-team/chromium/-/blob/master/debian/rules
ARGS=clang_use_chrome_plugins=false \

# disabled features
ARGS+=is_debug=false \
         use_libjpeg_turbo=true \
         use_custom_libcxx=false \
         use_unofficial_version_number=false \
         safe_browsing_use_unrar=false \
         enable_vr=false \
         enable_nacl=false \
         build_dawn_tests=false \
         enable_reading_list=false \
         enable_iterator_debugging=false \
         enable_hangout_services_extension=false \
         angle_has_histograms=false \
         angle_build_tests=false \
         build_angle_perftests=false \
         treat_warnings_as_errors=false \
         use_qt=false \
         is_cfi=false \
         chrome_pgo_phase=0 \

# enabled features
ARGS+=use_gio=true \
         is_official_build=true \
         symbol_level=0 \
         blink_symbol_level=0 \
         v8_symbol_level=0 \
         use_pulseaudio=true \
         link_pulseaudio=true \
         rtc_use_pipewire=true \
         icu_use_data_file=true \
         enable_widevine=true \
         v8_enable_backtrace=true \
         use_system_zlib=true \
         use_system_lcms2=true \
         use_system_libjpeg=true \
         use_system_libpng=true \
         use_system_libtiff=false \
         use_system_freetype=true \
         use_system_harfbuzz=true \
         use_system_libopenjpeg2=true \
         proprietary_codecs=true \
         ffmpeg_branding=\"Chrome\" \
         disable_fieldtrial_testing_config=true \

# configd
ARGS+=cc_wrapper=\"ccache\" \


if [ ! -d "out/Release" ]; then
    echo "gn gen Chromium release.."
    gn gen out/Release --ARGS="$ARGS"
fi

echo "autoninja .."
autoninja -C out/Release chrome
echo "Chromium build complete"

cd "$WRK"
set +e
