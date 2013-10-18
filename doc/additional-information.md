##Additional information
###Resolving date timezone issues
By default the the php.ini value ```date.timezone``` is not set and Symfony 
will yell at you for not having it set. 
SSH into the VM usign ```vagrant ssh``` and edit the php.ini file:

```
sudo nano /etc/php5/apache2/php.ini 
``` 
Search for the line: 
```
;date.timezone=
```
Replace it with:
```
date.timezone = America/Los_Angeles
```
Restart apache:
```
sudo service apache2 restart
```

###PHP MyAdmin
The main cookbook installs mysql and phpmyadmin out of the box. To have access to 
PHPMyAdmin and MySQL visit the following site on your web browser: ```http://localhost:8080/phpmyadmin```
You can access the PHPMyAdmin interface using username:root password:root. MySQL 
can also be accessed from the terminal using ```mysql -u root -proot``` (this is after you have accessed the vm via ```vagrant ssh```)

###MongoDB
MongoDB also comes out of the box unless it was commented out in the Vagrantfile. Access it through the terminal using the ```mongo``` command.

