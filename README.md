vkviewer
===========

Installation
============

1.1) Setup the virtual environment

   - At first set up the virtualenvironment 
	virtualenv --no-site-packages env
   - Install pyramid into the virtualenv
	~/path/to/env/bin/easy_install pyramid
   - Next install different librarys for the virtualenv
	~/path/to/env/bin/easy_install pyramid pyramid_mako SQLAlchemy psycopg2 WebHelpers pyramid_tm waitress Babel lingua
   - Add side packages to the virtual environment
        ln -s /usr/lib/python2.7/dist-packages/gdal* ~/path/to/env/lib/python2.7/site-packages/
	ln -s /usr/lib/python2.7/dist-packages/MapScript-6.0.1.egg-info ~/path/to/env/lib/python2.7/site-packages/
	ln -s /usr/lib/python2.7/dist-packages/GDAL-1.9.0.egg-info ~/path/to/env/lib/python2.7/site-packages/
	ln -s /usr/lib/python2.7/dist-packages/mapscript.py* ~/path/to/env/lib/python2.7/site-packages/
	ln -s /usr/lib/python2.7/dist-packages/_mapscript.so ~/path/to/env/lib/python2.7/site-packages/

1.2) Install vkviewer pyramid project
	cd ~/path/to/env/bin/python setup.py develop (or production)

1.3) Install Internationalization of pyramid project
	cd ~/path/to/env/bin/python setup.py extract_messages
	cd ~/path/to/env/bin/python setup.py update_catalog
	cd ~/path/to/env/bin/python setup.py compile_catalog

1.4) Run application
	cd ~/path/to/env/bin/pserve development.ini --reload

Deployment on apache server
===========================

1.) Apache configuration (/etc/apache2/sites-available/default)    

	# Use only 1 Python sub-interpreter. Multiple sub-interpreters
	WSGIApplicationGroup %{GLOBAL}
	WSGIPassAuthorization On
	WSGIDaemonProcess pyramid user=www-data group=www-data threads=4 \
	   	python-path=/usr/lib/python2.7/site-packages
	WSGIScriptAlias /vkviewer ~/repo/vk2-project/vkviewer/pyramid.wsgi

	<Directory ~/repo/vk2-project/vkviewer>
		WSGIProcessGroup pyramid
		Order allow,deny
		Allow from all
	</Directory>

2.) Set up pyramid.wsgi

3.) Install app

	../bin/python setup.py install

Run Tests
=========

1.) Pyramid Tests
	
	~/path/to/env/bin/python setup.py test

Tips
====

PYRAMID_RELOAD_TEMPLATES=1 bin/pserve development.ini --reload 


