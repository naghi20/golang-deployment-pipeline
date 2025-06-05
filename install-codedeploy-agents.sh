#!/bin/bash

# Usage: ./install_codedeploy.sh <AWS_REGION>
REGION=$1

if [ -z "$REGION" ]; then
  echo "Usage: $0 <AWS_REGION>"
  exit 1
fi

echo "Installing Ruby and wget..."
sudo yum install -y ruby wget

cd /home/ec2-user || exit

echo "Downloading CodeDeploy agent install script for region $REGION..."
wget https://aws-codedeploy-${REGION}.s3.${REGION}.amazonaws.com/latest/install

chmod +x ./install

echo "Running install script with auto option..."
sudo ./install auto

echo "Enabling and starting codedeploy-agent service..."
sudo systemctl daemon-reload
sudo systemctl enable codedeploy-agent
sudo systemctl start codedeploy-agent

echo "CodeDeploy agent installation complete. Service status:"
sudo systemctl status codedeploy-agent --no-pager
