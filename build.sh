#!/bin/sh
unset SSH_ASKPASS
unset SSH_ASKPASS_REQUIRE
ansible-playbook -i inventory.yaml playbooks/${1:-all}.yaml ${2}
