#!/bin/bash

echo "Moving Libraries and examples to ~/Arduino/libraries/"
mkdir -p ~/Arduino/libraries/
cp -r TVout* ~/Arduino/libraries/
cp -r IMG2TV* ~/Arduino/libraries/
echo "Goodbye..."
