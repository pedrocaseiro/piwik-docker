## This is my implementation of piwik, the open-source analytics platform, using docker and ansible.

### Explanation:

- **bin** - has the ansible deploy file
- **certs** - has our own apache certificates
- **config** - has the piwik configuration files (config.ini.php is not there on purpose, it is automatically generated after the first deploy!)
- **provisioning**
    - **group_vars**
        * **vars.yml** - an encrypted file with the important passwords
    - **templates**
        * **docker-compose.production.yml.j2** - the docker-compose file for production.   
    - **deploy.yml** - the ansible mighty deploy file!
    - **hosts** - the dashboard url
- **000-default.conf** - apache configuration
- **Dockerfile** - well, the Dockerfile - installs dependencies, installs piwik and sets up apache files, including ssl.
- **apache2.conf** - apache default configuration file
- **default-ssl.conf** - related to 000-default.conf
- **docker-compose.yml** - the almighty docker-compose file

### Instalation:

Before installing, read the **Explanation** topic!

Get a server running (we are using digital ocean Ubuntu Docker 1.11.2 on 14.04 image), since it already has Docker installed!

Clone this repository

#### List of files you need to change:
- `$ provisioning/hosts` - **YOURDASHBOARDHOST** - replace this with the URL/IP of your dashboard (where you are gonna have all the logs(
- `$ provisioning/deploy.yml` - git: repo=git@github.com:**pedrocaseiro/piwik-docker** - In case you fork this repository, you should change the `pedrocaseiro/piwik-docker` to `yourgithubusername/repositoryname`
- `$ provisioning/group_vars/vars.yml` - **YOUR USERNAME, YOUR PASSWORD, YOUR DATABASE NAME** - Replace these 3 fields with according to the username, password and database name you are gonna choose when doing the dashboard setup (this setup is explained a few lines below this one!)
- `000-default.conf`and `default-ssl.conf` - **YOUREMAIL, URLOFTHEDASHBOARD, YOURCERTIFICATE, YOURCERTIFICATEKEY** - Replace these 4 fields with your own email, the url of your dashboard, your website ssl certificate and your website ssl certificate key. These last 2 can be generated [here](http://www.selfsignedcertificate.com/). Don't forget to copy them to `/etc/ssl/`.
- 

Run the command `bin/deploy`, inside the repository. (you will be prompted to enter the vault password)

Tcharam, the analytics dashboard will be running at analytics.nourishcare.co.uk. (If it is the first installation, you will be prompted to make the initial dashboard configuration. Make sure the database name, username and password match the ones you wrote at the `provisioning/group_vars/vars.yml` file!)

If you make any changes, just run the command ``` $ bin/deploy ``` and everything should work properly.

To change usernames, passwords or even the database name, you need to delete the `provisioning/group_vars/vars.yml` file, create a new one, write your changes following the yml format:
```
---
username: yourusername
password: yourpassword
database: databasename
```

After that encrypt your `provisioning/group_vars/vars.yml` file by using the following command:
```
$ ansible-vault encrypt vars.yml
```
You'll be prompted to enter a password for the vault. **Make sure you remember it** because you'll need it every time you deploy, for security reasons!
