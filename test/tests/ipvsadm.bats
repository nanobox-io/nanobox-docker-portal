# source docker helpers
. util/docker.sh

@test "Start Container" {
  start_container "ipvsadm-test"
}

@test "Verify ipvsadm installed" {
  # ensure ipvsadm executable exists
  run docker exec "ipvsadm-test" bash -c "[ -f /sbin/ipvsadm ]"

  [ "$status" -eq 0 ]
}

@test "Stop Container" {
  stop_container "ipvsadm-test"
}
