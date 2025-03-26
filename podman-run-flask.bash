podman build --no-cache --rm -f Containerfile -t flask:demo .
podman run --interactive --tty -p 8001:5000 flask:demo
echo "browse http://localhost:8001/"
