#!/usr/bin/env bash

#sudo nixos-generate-config --show-hardware-config > ./hardware-configuration.nix
NIX_CONFIG="experimental-features = nix-command flakes"

sudo nixos-rebuild boot --flake ./#server1
