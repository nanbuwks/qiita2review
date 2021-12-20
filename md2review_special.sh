SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
ruby $SCRIPT_DIR/escapeincode.rb $1.md | ruby $SCRIPT_DIR/preprocess.rb |  md2review | ruby -Ku $SCRIPT_DIR/scalemd.rb > $1.re

