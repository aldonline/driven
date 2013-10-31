# Driven

* *What?* A Google Drive Driven Micro Publishing Platform
* *Why?* I use Google Docs for everything. Period.
* *How?* A Node.js app that talks to the Drive Api, eats your docs and spits out a nice looking website.


![Driven Logo](https://raw.github.com/aldonline/driven/master/public/driven-logo.png)


# Document Conventions

In order for the magic to happen you docs need to follow some rules.


# Installing

You need a bunch of things ( sorry - FOL )

* A Mongo Database
* A Google Apps Account ( TODO )
* Some Google Docs documents that you want to share with the word
* Node.js ( version 0.10.18 or above - due to an HTTPS bug )


```shell

# clone and install
git clone https://github.com/aldonline/driven.git
cd driven
npm install -d


# set some env vars for the server

# You Google App stuff
export GOOGLE_APPS_ID="XXYYZZ.apps.googleusercontent.com"
export GOOGLE_APPS_SECRET="XXYYZZ"
export GOOGLE_OAUTH_REDIRECT_URL="http://localhost/auth/google/redirect"

# Mongo DB stuff
export MONGO_URL="mongodb://user:passwor@foo.mongohq.com:10063/database-name"

# This is the main document ( the one that holds all metadata and the index )
export INDEX_DOC_ID="UUJJNN"

# The port on which you want to run the server
export PORT=9000


# You can now start the server
npm start


# open a browser
open http://localhost:9000/


```




