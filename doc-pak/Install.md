# Install instruction for the vkviewer application

Actual the vkviewer project contains two parts. On part is the portal application. The portal application is mainly based on the <a href="http://www.pylonsproject.org/">python pyramid webframework </a> and uses a <a href="http://www.postgresql.org/">PostgreSQL / PostGIS</a> database as database backend. The portal application contains `python` and `javascript` code for searching, displaying and georeferencing historic plane survey sheets. Next to the portal application the georeference directory contains a georeferencedaemon. This daemon has it own setting files and could be run on a seperate system. It main task is to update the different data backends of the spatial data infrastructure. Especially to push changes on the georeference data to the services.

## Installation of the vkviewer portal application (debian)

### Package Dependencies

	* postgresql-9.1 (>9.1) / postgis (1.5)
	* libgdal1  (1.9) / libgdal1-dev / python-gdal 
	* python-mapscript
	* python-dev
	* cgi-mapserver
	* imagemagick

### Creating of python virtual environment

For creating the virtual envrionment the tool `virtualenv` (could be install through python-virtualenv) is used. Frist we create the virtual environment.

	virtualenv --no-site-packages python_env

Than we install pyramid together with the needed python libraries.

	./python_env/bin/easy_install pyramid pyramid_mako SQLAlchemy==0.8.3 psycopg2 WebHelpers pyramid_tm waitress Babel lingua PIL requests lockfile python-daemon

After that we manually add the gdal and mapscript bindings from the system wide installation.

    ln -s /usr/lib/python2.7/dist-packages/gdal* ./python_env/lib/python2.7/site-packages/ 
	ln -s /usr/lib/python2.7/dist-packages/MapScript-6.0.1.egg-info ./python_env/lib/python2.7/site-packages/ 
	ln -s /usr/lib/python2.7/dist-packages/GDAL-1.9.0.egg-info ./python_env/lib/python2.7/site-packages/
	ln -s /usr/lib/python2.7/dist-packages/mapscript.py* ./python_env/lib/python2.7/site-packages/ 
	ln -s /usr/lib/python2.7/dist-packages/_mapscript.so ./python_env/lib/python2.7/site-packages/ 
	ln -s /usr/lib/python2.7/dist-packages/osgeo/ ./python_env/lib/python2.7/site-packages/ 

`Make sure you have added a projection entry for the epsg:900913 to your local proj library. In case of debian add the following entry to /usr/share/proj/epsg`

	<900913> +proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext +over no_defs

### Installation of the application 

The vkviewer application right now hosts two main parts. One part is the pure web application. The other is a directory of scripts for updating the data backend. Both parts a greping some configuration parameter from the `vkviewer/settings.py`. So before running the application this file has to be configured properbly. 

Before the application or the scripts could be used the application has to be install, so further dependencies could be download and installed. 

	./python_env/bin/python setup.py install (for production)
	./python_env/bin/python setup.py develop (for development)

### Install or Update your backend language dictionary

The backend language dictionary is based on **Babel** and **Lingua**. The language files are found in `vkviewer/locale`. To update the dictionary run the following commands.

As first search for new dictionary tokens in your files.

	./python_env/bin/python setup.py extract_messages

Than update your catalog.

	./python_env/bin/python setup.py update_catalog

Now you can update your dictionaries files (**.po**) in the local directory.

	vim vkviewer/locale/de/LC_MESSAGES/vkviewer.po

At the end compile your dictionaries.
	
	./python_env/bin/python setup.py compile_catalog


##' Run vkviewer as a WSGI application over apache.

It is possible to run the vkviewer as WSGI application with the apache server. For this mod_wsgi for apache has to be installed. Also you have to first install your application with `setup.py install`.

As first you have generate a `pyramid.wsgi` file in the root folder of you application (default: vkviewer). This pyramid scripts should look basicly like this.

```
import sys, site, os

site.addsitedir('~/vkviewer/python_env/lib/python2.7/site-packages')

sys.path.append('~/vkviewer/python_env')
os.environ['PYTHON_EGG_CACHE'] = '~/vkviewer/python_env/dist'

from pyramid.paster import get_app, setup_logging
ini_path = '~/vkviewer/production.ini'
setup_logging(ini_path)
application = get_app(ini_path, 'main')
```

Add than to your virtualhost configuration (default is: `/etc/apache2/sites-available/default`) the following lines.

```
# Use only 1 Python sub-interpreter. Multiple sub-interpreters
WSGIApplicationGroup %{GLOBAL}
WSGIPassAuthorization On
WSGIDaemonProcess pyramid user=www-data group=www-data threads=4 \
	python-path=/usr/lib/python2.7/site-packages
WSGIScriptAlias /vkviewer ~/vkviewer/pyramid.wsgi

<Directory ~/vkviewer>
	WSGIProcessGroup pyramid
	Order allow,deny
	Allow from all
</Directory>
```

The `python-path` reference to your python interpreter and the `WSGIScriptAlias` defines your server endpoint and your pyramid.wsgi file. For more information see the [pyramid docs](http://docs.pylonsproject.org/projects/pyramid/en/1.0-branch/tutorials/modwsgi/index.html).

##' Install mail client

For supporting the sending of contact requests by automatic sending a mail to administrator address install and configure the exim4 email client.

	apt-get install exim4
	dpkg-reconfigure exim4-config (configure mail client)
