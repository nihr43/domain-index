from python:3-slim

run mkdir -p /srv/ &&\
    echo 'looking for <a href=https://signal.nih.earth>signal.nih.earth</a>?' > /srv/index.html

cmd ["python", "-m", "http.server", "-d", "/srv/"]
