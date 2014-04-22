load test_helper

@test "writes the current iTunes artist to .music" {
  stub dotmusic-itunes "echo Radiohead"
  run $dotmusic

  cat $musicfile | grep "Radiohead"
  [ $status -eq 0 ]
}

@test "stores multiple artists" {
  stub dotmusic-itunes "echo Radiohead"
  run $dotmusic
  stub dotmusic-itunes "echo The Beatles"
  run $dotmusic

  cat $musicfile | line 1 | grep "Radiohead"
  cat $musicfile | line 2 | grep "The Beatles"
  [ $status -eq 0 ]
}

@test "creates multiple artists for partial matches" {
  stub dotmusic-itunes "echo Radiohead"
  run $dotmusic
  stub dotmusic-itunes "echo Radiohead Coverband"
  run $dotmusic

  cat $musicfile | line 1 | grep "Radiohead"
  cat $musicfile | line 2 | grep "Radiohead Coverband"
  [ $status -eq 0 ]
}

@test "does not create duplicates" {
  stub dotmusic-itunes "echo Radiohead"
  run $dotmusic
  run $dotmusic

  cat $musicfile | wc -l | grep "1"
  [ $status -eq 0 ]
}

@test "does not create .music with no artist" {
  stub dotmusic-itunes "echo"
  run $dotmusic

  [ ! -f $musicfile ]
  [ $status -eq 0 ]
}

@test "does not append .music with no artist" {
  touch $musicfile
  stub dotmusic-itunes "echo"
  run $dotmusic

  cat $musicfile | wc -l | grep "0"
  [ $status -eq 0 ]
}