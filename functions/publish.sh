#!/bin/bash

cd functions
echo "Setting up virtual environment..."
python3 -m venv .venv
source .venv/bin/activate

echo "Installing dependencies..."
pip install -r requirements.txt

echo "Publishing Azure Function..."
func azure functionapp publish func-resume-jaan --python