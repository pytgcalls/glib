source /dev/stdin <<< "$(curl -s https://raw.githubusercontent.com/pytgcalls/build-toolkit/refs/heads/master/build-toolkit.sh)"

require venv

import .env
import libraries.properties
import meson from python3
import ninja from python3

if [[ "$(uname -m)" == "x86_64" ]]; then
    C_ARGS="-mno-avx2"
    CPP_ARGS="-mno-avx2"
else
    C_ARGS=""
    CPP_ARGS=""
fi

build_and_install "libexpat/expat" configure-static
build_and_install "glib" meson-static --buildtype=plain -Dtests=false -Dc_args="$C_ARGS" -Dcpp_args="$CPP_ARGS"

copy_libs "libexpat" "artifacts"
copy_libs "glib" "artifacts" "ffi" "pcre2-8" "gmodule-2.0" "glib-2.0" "gobject-2.0" "gio-2.0"
cp "$DEFAULT_BUILD_FOLDER/glib/build/lib/glib-2.0/include/glibconfig.h" artifacts/include/glib-2.0