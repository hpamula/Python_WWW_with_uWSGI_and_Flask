echo "Disk usage at the beginning:"
du -sh *
rm -r www
echo "Disk usage after rm -r www:"
du -sh *
mkdir www
cd www
cat <<EOF >wsgi.py
from flask_app import app as application
EOF
cat <<EOF >flask_app.py
from flask import Flask
from sys import version

app = Flask(__name__)

@app.route("/")
def flask_app():
    return "Hello uWSGI from python version: <br>" + version
EOF
python -m venv .venv
. .venv/bin/activate
pip install Flask
pip install pyuwsgi
cd ..
echo "Check if don't need to install these; maybe they're preinstalled:"
echo "Disk usage after setup:"
du -sh *
