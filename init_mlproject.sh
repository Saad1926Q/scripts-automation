#!/bin/sh

if [ -z $1 ];then
  echo "pass the project name as argument"
  exit 1
fi

project_name=$1

mkdir "$project_name"
cd "$project_name"

git init

python3 -m venv "${project_name}-env"
. "${project_name}-env/bin/activate"

pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128

touch .gitignore

echo "${project_name}-env">>.gitignore

echo "Project '$project_name' is ready!"

touch main.py
chmod +x main.py
echo "import torch">>main.py
echo "print(torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'No CUDA available')">>main.py
