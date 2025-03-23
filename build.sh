# shellcheck disable=SC1090
source <(curl -s https://raw.githubusercontent.com/pytgcalls/build-toolkit/refs/heads/master/build-toolkit.sh)

require_venv

GLIB_VERSION=$(get_version "glib")

build_and_install https://github.com/GNOME/glib.git "$GLIB_VERSION" meson-static --buildtype=plain -Dtests=false

mkdir -p artifacts/lib
mkdir -p artifacts/include
run cp -r build_output/lib/*.a artifacts/lib/
run cp -r build_output/include/glib-2.0/* artifacts/include/
run cp build_output/lib/glib-2.0/include/glibconfig.h artifacts/include/