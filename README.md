# Make dynamic WWW site with Python using uWSGI and Flask

### How to run using alwaysdata.com
It's possible using 100MB free plan<br>

In https://admin.alwaysdata.com/site choose 'Modify' option at your new site

In 'Addresses' tab:
- type '<username\>.alwaysdata.net'

In 'Configuration':
- under 'Type' choose 'Python WSGI'
- under 'Application path' choose '/www/wsgi.py'
- under 'Working directory' choose '/www/'
- under 'virtualenv directory' choose '/www/.venv/'

In 'Advanced configuration':
- under 'uWSGI additional settings' write 'py-autoreload = 1'

Keep in mind that it auto-reloads changes in all files only when any .py file changed,
so it's not ideal, but I didn't manage 'hot-restart = true' to work.
It's good enough for now.

Click 'Submit' in bottom right corner.<br>
In https://admin.alwaysdata.com/ssh/ choose 'Modify' option.<br>
and under 'Password' choose some password.<br>
Enable 'Enable password-based login' checkbox.<br>
Click 'Submit' in bottom right corner.<br>
Go back to https://admin.alwaysdata.com/ssh/ and click 'on the Web'<br>
Log in using username (which is displayed in link as https://ssh-<username\>.alwaysdata.net/)<br>
and newly created password.<br>
Now you need to copy setup.sh file into ~ directory.<br>
You can do this using FileZill'a FTP, SSH or WebDAV<br>
but probably to easiest way is to just paste file with its content by typing:<br>
```bash
echo -e "echo \"Disk usage at the beginning:\"\ndu -sh *\nrm -r www\necho \"Disk usage after rm -r www:\"\ndu -sh *\nmkdir www\ncd www\ncat <<EOF >wsgi.py\nfrom flask_app import app as application\nEOF\ncat <<EOF >flask_app.py\nfrom flask import Flask\nfrom sys import version\n\napp = Flask(__name__)\n\n@app.route(\"/\")\ndef flask_app():\n    return \"Hello uWSGI from python version: <br>\" + version\nEOF\npython -m venv .venv\n. .venv/bin/activate\npip install Flask\n# pip install pyuwsgi\necho \"\'pip install pyuwsgi\' was not executed since on alwaysdata it is preinstalled.\"\ncd ..\necho \"Check if don't need to install these; maybe they're preinstalled:\"\necho \"Disk usage after setup:\"\ndu -sh *" > setup.sh
```
Then execute first commands to be able to run setup.sh and then run it<br>
```bash
chmod +x setup.sh
./setup.sh
```
Now in https://admin.alwaysdata.com/site choose 'Restart' option at your new site to ensure that changes were saved.
Now by going to https://\<username>.alwaysdata.net/ you should see basic site with default text:<br>
Hello uWSGI from python version:<br>
3.12.0 (main, Dec 5 2023, 07:53:35) [GCC 8.3.0]

If everything works, you can update files inside www directory.
