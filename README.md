# server-config-project
Configuration details for the server for the Catalog Project.

### Server IP & ssh port:

    34.212.27.208:2222

### Project uri:

    34.212.27.208
    
## Configuration Summary:
- updated & upgraded packages
- added users chris & grader
- gave new users sudo capability using usermod
- added authorized keys for ssh for new users
- configured ufw to:
    - allow outgoing as default 
    - deny incoming as default
    - allow ssh on 2222/tcp
    - allow www
    - allow ntp
- enabled ufw
- configured sshd to:
    - not permit root ssh
    - not permit password authentication over ssh
    - communicate over port 2222
    - allow ssh from chris & grader
- installed:
    - apache2
    - apache2-bin
    - python3
    - python3-pip
    - libapache2-mod-wsgi-py3
    - mysql-server
    - mysql-client
    - libmysqlclient-dev
    - python-mysqldb
- configured apache to run flask apps using [this tutorial](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-flask-application-on-an-ubuntu-vps)
- pip-installed:
    - virtualenv
    - mysqlclient
    - all from requirements.txt from [Catalog Project](https://github.com/satetheus/CatalogProject)
- in mysql:
    - created catalog database
    - created catalog_user database user
    - gave full permissions to catalog_user for the catalog database
- git cloned [Catalog Project](https://github.com/satetheus/CatalogProject)
- edited \__init\__.py, models.py, controls.py, auth.py, apis.py, & addgames.py to access mysql database
- ran python3 addgames.py to fill database with sample items
- restarted apache2 to check changes
- rebooted vm to enable ufw
