#!/bin/bash
cd /tmp
pip install -r requirements.txt
nohup python3 app.py > app.log 2>&1 &
