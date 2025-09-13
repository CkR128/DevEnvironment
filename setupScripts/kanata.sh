#!/bin/zsh
brew install --cask karabiner-elements
echo "------------------------------------"
echo "Run Karabiner from Applications and make sure to set up these permissions:"
echo ""
echo "Login Items & Extensions > Karabiner-Elements Non-Privileged Agents (enable)"
echo "Login Items & Extensions > Karabiner-Elements Privileged Daemons (enable)"
echo "Login Items & Extensions > Driver Extensions > .Karabiner-VirtualHIDDevice-Manager (enable)"
echo "------------------------------------"
brew install kanata
echo "------------------------------------"
echo "Run kanata with sudo and use --cfg path to kanatarc file."
echo "------------------------------------"
