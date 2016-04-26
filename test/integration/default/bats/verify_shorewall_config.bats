#!/usr/bin/env bats

@test "check shorewall configuration" {
  run shorewall check
  [ "$status" -eq 0 ]
}
