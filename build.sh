# shellcheck disable=SC1090
source <(curl -s https://raw.githubusercontent.com/pytgcalls/build-toolkit/refs/heads/master/build-toolkit.sh)

require_venv

GLIB_VERSION=$(get_version "glib")

build_and_install https://github.com/GNOME/glib.git "$GLIB_VERSION" meson-static --prefix="$(pwd)/glib/build/" --buildtype=plain -Dtests=false

mkdir -p artifacts/lib
mkdir -p artifacts/include
cp -r "$(pwd)"/glib/build/lib/*.a artifacts/lib/
cp -r "$(pwd)"/glib/build/include/glib-2.0/* artifacts/include/
cp "$(pwd)"/glib/build/lib/glib-2.0/include/glibconfig.h artifacts/include/