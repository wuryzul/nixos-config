default:
  @just --list

rebuild-user:
  scripts/home-manager-flake-rebuild.zsh

rebuild-system:
  scripts/system-flake-rebuild.zsh

rebuild-full:
  just rebuild-system
  just rebuild-user

update:
  nix flake update

rebuild-update:
  just update
  just rebuild-full