#Set up your first project
##Installing Symfony2

Composer has been also pre-installed and it can be used right away. to install symfony go to the vagrant directory and 
follow the instructions in "[Installing and Configuring Symfony](http://symfony.com/doc/current/book/installation.html)"

```
composer create-project symfony/framework-standard-edition symfony
composer install
```

To test Symfony visit the following page in the web browser ```http://symfony.web:8080/app_dev.php```
Notice that this site has it's own domain as long as the symfony project has been 
created in the Sites directory under the name ```symfony```. This is because I have 
conveniently added the vhost configuration in the Vagrantfile.

##Creating additional Vhosts
To add more vhost pointing to different directories, append as many more entries in the 
vhost array in the Vagrantfile. 

```
        :devproject => {
            :name => "devproject",
            :host => "dev.project.com", 
            :aliases => ["devproject"],
            :docroot => "/devproject/public"
        }
```

##Compatibility
That's it, I have tested this setup in Mac OS 10.8.5 and Windows 8 using gitbash.


[<< Tutorial](tutorial.md) | [Additional Information >>](additional-information.md).