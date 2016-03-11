# source docker helpers
. util/docker.sh

@test "Start Container" {
  start_container "portal-test"
}

@test "Verify portal installed" {
  # ensure portal executable exists
  run docker exec "portal-test" bash -c "[ -f /usr/local/bin/portal ]"

  [ "$status" -eq 0 ]
}

@test "Stop Container" {
  stop_container "portal-test"
}
