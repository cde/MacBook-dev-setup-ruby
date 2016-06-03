# Mac OS X Dev Setup

This document describes how I set up my basic ruby developer environment on a new MacBook from scratch.
(some of them are kinda obvious :p ) The steps below were tested on OS X El Capitan and assumes you are semi-new to Mac.

I will set up mainly for [Ruby](http://www.ruby-lang.org/) development.
Setting for javascript environment can be found here


- [System update](#system-update)
- [System preferences](#system-preferences)
- [Install your favorite browser](#install-your-favorite-browser)
- [Install your favorite editor](#install-your-favorite-editor)
- [iTerm2](#iterm2)
- [Homebrew](#homebrew)
- [Git](#git)
- [Heroku](https://github.com/cde/MacBook-dev-setup-ruby#heroku)
- [Ruby](#ruby)
- [Setting Up A Database](#setting-up-a-database)
- [Terminal settings](#terminal-settings)

## System update
It's always a good idea to Update the system :p. For that: **Apple Icon > Software Update...**

## System preferences
In a new computer, there are a couple basic tweaks I like to make to the System Preferences. Feel free to follow these, or to ignore them, depending on your personal preferences.

In **Apple Icon > System Preferences**:

- Trackpad > Tap to click
- Dock > Automatically hide and show the Dock

## Install your favorite browser

Mine happens to be Chrome. Google Canary is fun for coding too!
Download from [www.google.com/chrome](https://www.google.com/intl/en/chrome/browser/).

On the Mac, most applications are installed the way below. I'll use **Google Chrome** as an example.

- Open the **.dmg** file once it's done downloading. which will mount the disk image.
- In **Finder**, drag and drop the **Google Chrome** app into the Applications folder.
- Unmount the disk in Finder, (the small "eject" icon next to the disk under **Devices**).

## Install your favorite editor

Everyone has their preferences. I'll leave it up to you. Download and install your preference. Here there are some options I have personally used:
- [Atom](https://atom.io/) (free)
- [Brackets](http://brackets.io/) (free)
- [Sublime](http://www.sublimetext.com) (paid)
- [Vim](http://www.vim.org/) (free)

Although [RubyMine](https://www.jetbrains.com/ruby/) is an IDE, it's pretty popular too. You can find some popular editors [here](https://developer.mozilla.org/en-US/Learn/Common_questions/Available_text_editors)

## iTerm2
Since you're going to be spending a lot of time in the command-line, a better terminal than the default is ideal
Download and install [iTerm2](http://www.iterm2.com/) (depending on your personal preferences the stable or beta version ).

In **Finder**, drag and drop the **iTerm** Application file into the **Applications** folder. Launch iTerm, through the Launchpad

Feel free to follow these changes or to ignore them, depending on your personal preferences:

In **iTerm > Preferences**
- under the  **General**, uncheck **Confirm closing multiple sessions** and **Confirm "Quit iTerm2 (Cmd+Q)" command** under the section Closing.
- In the tab **Profiles**, you can create your own **profile name** with the "+" icon. Then, select **Other Actions... > Set as Default**.
- Under the section **Window**, change the window size to your preferences. For example Columns: 125 and Rows: 25.
- Under the section **Colors**, select **Color Presets** and select your preferences. I like to use Solarized Dark theme.

Clicking the red "X" in the upper left save automatically in OS X preference panels. Close the window and open a new one to see the size change.

## Homebrew
Package managers make it so much easier to install and update applications (for Operating Systems) or libraries (for programming languages). I use the popular one for OS X  [Homebrew](http://brew.sh/).

### Install

In the terminal prompt paste the following line , hit Enter, and follow the steps on the screen:

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

You will probably be asked to install command line developer tools and Xcode if you have a new machine as it was my case.

**Command Line Tools** for **Xcode** is an important dependency before Homebrew can work. These include compilers that will allow you to build things from source.

Unless you're developing iPhone or Mac apps, you only need to install the Command Line Tools, without Xcode. If Homebrew doesn't ask you to install XCode CommandLine Tools directly, you can go to [http://developer.apple.com/downloads](http://developer.apple.com/downloads), and sign in with your Apple ID, and search for "command line tools" and download the latest **Command Line Tools (OS X 10.11) for Xcode 7.3.1** (my version Jun 2016).

We need to tell the system to use programs installed by Homebrew rather than the OS default if it exists.
We do this by adding  /usr/local/bin to your $PATH environment variable:

    echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

Run the following command to make sure everything works:

    brew doctor

Now that we have Homebrew installed, we can use it to install packages.

### Basic Usage

To install a package (or **Formula** in Homebrew vocabulary) simply type:

    brew install <formula>

To update Homebrew's directory of formula, run:

    brew update

To see if any of your packages need to be updated:

    brew outdated

To update a package:

    brew upgrade <formula>

Homebrew keeps older versions of packages installed, in case you want to roll back. That rarely is necessary, so you can do some cleanup to get rid of those old versions:

    brew cleanup

To see what you have installed (with their version numbers):

    brew list --versions

Now let's use Homebrew! :p    

## Git

I'll be using Git for version control system and [Github](https://github.com/) repo. ***You will need to create a Github account if don't have already one.***

    brew install git

When done, to test that it installed fine you can run:

    git --version

And `$ which git` should output `/usr/local/bin/git`.   

### Basic configuration

The [first thing](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup#_first_time) you should do when you install Git is to set your user name and email address.

    git config --global user.name "YOUR NAME"
    git config --global user.email "YOUR@EMAIL.com"

This will add user info to **.gitconfig** file in your home directory.

You can download some basic configuration [.gitconfig](https://raw.githubusercontent.com/cde/MacBook-dev-setup/master/.gitconfig) file to your home directory:

    cd ~
    curl -O https://raw.githubusercontent.com/cde/MacBook-dev-setup/master/.gitconfig

It will add some color to the `status`, `branch`, and `diff` Git commands

The next step is to generate a SSH key and add it to your Github account.

    ssh-keygen -t rsa -C "YOUR@EMAIL.com"

Copy and paste the output of the following command and [paste it here](https://github.com/settings/ssh)
    cat ~/.ssh/id_rsa.pub

You can check and see if it worked:  

    ssh -T git@github.com

You should get a message like this
    **Hi <your username>! You've successfully authenticated, but GitHub does not provide shell access.**    

# Heroku
[Heroku](http://www.heroku.com/) is a [Platform-as-a-Service](http://en.wikipedia.org/wiki/Platform_as_a_service) (PaaS) that enables developers to run their application in the cloud. There are other similar solutions out there. Heroku seems to be the most popular.

**Note:**  You will need to create a Heroku account if don't have already one using the same email you used on your Github account.

### Install
There are two basic ways to install Heroku.

1 - Homebrew includes `heroku-toolbelt` formula:


    brew install heroku-toolbelt


To always have the most recent version run:

    heroku update

2 - Download [toolbelt heroku](https://toolbelt.heroku.com/osx) and follow the instructions.

    heroku login


# Ruby

I'm going to use [rbenv](https://github.com/rbenv/rbenv) to install and manage my Ruby versions.

Run the following commands in your Terminal:

    brew install rbenv ruby-build

**Add rbenv to bash so that it loads every time you open a terminal**

    echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
    source ~/.bash_profile

### Install Ruby

    rbenv install <ruby version>


    rbenv install 2.3.1
    rbenv global 2.3.1
    ruby -v

### Install Rails

    gem install rails -v <rails version>


    gem install rails -v 4.2.6

Rails is now installed, but in order for us to use the rails executable, we need to tell rbenv to see it:

    rbenv rehash
    rails -v
    # Rails 4.2.6


## Setting Up A Database
Rails ships with sqlite3 as the default database, stored as a simple file on disk.
Changes are that you will probably want something more robust like MySQL or PostgreSQL like myself.

### PostgreSQL
You can install [PostgreSQL](https://www.postgresql.org/) server and client from Homebrew:

    brew install postgresql

Once this command is finished, it gives you a couple commands to run. Follow the instructions and run them:

    # To have launchd start postgresql now and restart at login:
    brew services start postgresql
    # Or, if you don't want/need a background service you can just run:
    postgres -D /usr/local/var/postgres

By default the postgresql user is your current OS X username with no password.

#### Postgres GUI
In terms of GUI client for postgres, I'm used to [Pgadmin]
(https://www.pgadmin.org/). But feel free to use whichever you prefer. Some options [here.](https://wiki.postgresql.org/wiki/Community_Guide_to_PostgreSQL_GUI_Tools)

### MySQL
You can install [MySQL](http://www.mysql.com/) server and client from Homebrew:

    brew install mysql

When done, it gives you a couple commands to run. Follow the instructions and run them:    

    # We've installed your MySQL database without a root password. To secure it run:
    mysql_secure_installation

    # To connect run:
    mysql -uroot


    # To have launchd start mysql now and restart at login:
    brew services start mysql
    # Or, if you don't want/need a background service you can just run:
    mysql.server start

#### MySQL Workbench

In terms of a GUI client for MySQL, I'm used to the official and free [MySQL Workbench](http://www.mysql.com/products/workbench/). But feel free to use whichever you prefer.

## Terminal settings
At this point you could customize your settings. As example you could have [.aliases](https://github.com/cde/MacBook-dev-setup-ruby/blob/master/.aliases) and/or customize your ***prompt***.

Add the bellow lines to ***.bash_profile*** to load any setting files.

    for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
      [ -r "$file" ] && source "$file"
    done
    unset file
