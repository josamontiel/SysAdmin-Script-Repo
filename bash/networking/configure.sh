#!/bin/bash

show_help() {
  echo "Usage: $0 -i interface_name -s subnet_mask -g default_gateway"
  echo "Configure subnet mask and default gateway for a network interface."
  echo "Flags:"
  echo "  -i    Interface name (e.g., eth0)"
  echo "  -s    Subnet mask (e.g., 255.255.255.0)"
  echo "  -g    Default gateway (e.g., 192.168.1.1)"
}

try {
  while getopts ":i:s:g:h" opt; do
    case $opt in
      i)
        interface_name="$OPTARG"
        ;;
      s)
        subnet_mask="$OPTARG"
        ;;
      g)
        default_gateway="$OPTARG"
        ;;
      h)
        show_help
        exit 0
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        show_help
        exit 1
        ;;
      :)
        echo "Option -$OPTARG requires an argument." >&2
        show_help
        exit 1
        ;;
    esac
  done

  if [[ -z "$interface_name" || -z "$subnet_mask" || -z "$default_gateway" ]]; then
    echo "Error: Missing arguments."
    show_help
    exit 1
  fi

  # Configure subnet mask
  sudo ifconfig $interface_name netmask $subnet_mask

  # Configure default gateway
  sudo route del default
  sudo route add default gw $default_gateway

  echo "Configuration updated successfully."
} catch {
  echo "An error occurred: $@"
}
