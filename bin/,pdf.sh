#! /usr/bin/env nix-shell
#! nix-shell -i bash -p poppler_utils -p pngquant -p ocrmypdf

set -euf -o pipefail

if [ "$1" = "--force" ] || [ "$1" = "-f" ]
then
  shift
  force=1
else
  force=0
fi

opts="--skip-text -l eng+ita+deu --clean -O2 -q"

for file in "$@"
do
  if [ "$force" = 1 ]
  then
    run=1
    opts="$opts --tesseract-timeout 0"
  else
    len=$(pdftotext "$file" - 2>/dev/null | head | wc -c)
    echo $len
    run=$([[ "$len" -lt 5 ]] && echo 1 || echo 0)
    echo $run
  fi
  if [ "$run" = 1 ]
  then
    echo
    echo "Processing $file..."
    old="${file%.*}_old.pdf"
    mv "$file" "$old"
    if TMPDIR=/tmp ocrmypdf $opts "$old" "$file"
    then
      old_size=$(stat --printf="%s" "$old")
      new_size=$(stat --printf="%s" "$file")
      if [ "$force" = 1 ] && [[ $new_size -gt $old_size ]]
      then
        echo "... old file is smaller ($old_size -> $new_size): undoing"
        mv "$old" "$file"
      fi
    else
     echo "... error processing $file"
    fi
  fi
done
