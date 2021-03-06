setup() {
  DM_TMPDIR=$BATS_TMPDIR/dotmusic
  DM_STUBS=$DM_TMPDIR/stubs
  PATH=$DM_STUBS:$PATH

  musicfile=$DM_TMPDIR/.music
  dotmusic=$PWD/bin/dotmusic

  rm -rf $DM_TMPDIR
  mkdir -p $DM_TMPDIR
  cd $DM_TMPDIR
  git init > /dev/null
}

teardown() {
  echo $status: $output
}

line() {
  head -n $1 | tail -n 1
}

stub() {
  stub=$DM_STUBS/$1
  mkdir -p $DM_STUBS
  echo "#!/bin/bash" > $stub
  echo "$2" >> $stub
  chmod +x $stub
}
