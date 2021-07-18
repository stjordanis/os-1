set -eu

OUT=gen/javascript
STDLIB_SRC=_build/default/lib/gleam_stdlib/src
STDLIB_OUT=node_modules/gleam_stdlib

rm -fr $OUT $STDLIB_OUT

gleam compile-package \
  --name gleam_stdlib \
  --target javascript \
  --src $STDLIB_SRC \
  --out $STDLIB_OUT
cp $STDLIB_SRC/*.js $STDLIB_OUT/

gleam compile-package \
  --name gleam_os \
  --target javascript \
  --src src \
  --test test \
  --lib $STDLIB_OUT \
  --out $OUT
cp src/*.js $OUT/

node bin/run-tests.js
