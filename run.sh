sudo service docker start
echo "Do you wish to rebuild the docker image?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) docker build --no-cache -t cuda-server . ; break;;
        No ) break;;
    esac
done


docker run --privileged -d --init \
  --restart unless-stopped \
  --name cuda-code-server \
  --gpus=all \
  --ipc=host \
  --user="$(id -u):$(id -g)" \
  --volume="$PWD/../projects:/projects" \
  --volume="$PWD/code-server:/home/coder/.config/code-server" \
  --env-file "$PWD/env.list" \
  -p 8083:8080 \
  cuda-server
#   --volume="$HOME/.config:/home/coder/.config" \
