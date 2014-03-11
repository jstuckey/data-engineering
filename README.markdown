Installation
============

Instructions for setting up this dev challenge.

Ruby
----
This is a Ruby on Rails app, so you will need to have Ruby installed on your system. The minimum supported Ruby version is 1.9.3. If you already have 1.9.3 or higher installed, skip ahead to the next section.

To check your Ruby version, type the following in the command line:
```sh
ruby --version
```

The easiest way to install various versions of Ruby on your system is [Ruby Version Manager], a.k.a. RVM. Check the RVM website for installation information.

Download Project
----------------

First, download the project to your system. You can use git to clone the project:

```sh
git clone https://github.com/jstuckey/data-engineering.git
```

Or download it as a .zip file:

```
https://github.com/jstuckey/data-engineering/archive/master.zip
```

After downloading, navigate to the project directory.

Bundler
-------

This application's dependencies are managed using [Bundler].

To check if Bundler is installed, type the following in the command line:

```sh
which bundle
```

If the bundle executable is not found, install it using Ruby Gems:

```sh
gem install bundler
```

Once [Bundler] is ready, install the required gems for this application. From the project's root directory, type the following:

```sh
bundle install
```

Database Setup
--------------

Type the following in the command line to prepare the database:

```sh
bundle exec rake db:setup
```

Run Project
-----------

The project is now ready to be used. In this scenario, we are running the application in development mode.

Start the rails app:

```sh
rails s
```

Open the following URL in a browser. Make sure no other applications are currently using port 3000 on your machine.

```
http://localhost:3000/
```

To stop the application, type ```command + c``` in the command line.


Run Tests
---------

Prepare the test database by executing the following in the command line:

```sh
bundle exec rake db:test:load
```

Run the tests with the following command:

```sh
bundle exec rake test
```


[Bundler]:http://bundler.io/
[Ruby Version Manager]:https://rvm.io/