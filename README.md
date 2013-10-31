# Driven

* *What?* A Google Drive Driven Micro Publishing Platform
* *Why?* I use Google Docs for everything. Period.
* *How?* A Node.js app that talks to the Drive Api, eats your docs and spits out a nice looking website
* *When?* Soon. This stuff is in early alpha. But I am using it personally so it will be ready pretty soon.
  * In the meantime: **Star this repository so you can get notified**


![Driven Logo](https://raw.github.com/aldonline/driven/master/public/driven-logo.png)


# Installing

Driven is a Node.js app that serves your docs dynamically over HTTP. You will need several
things to get it running:

* A Mongo Database
* A Google Apps API Account ( Link? )
* Some Google Docs documents that you want to share with the world
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

# This is the index document ( the one that holds all metadata and the list of docs you wish to publish )
export INDEX_DOC_ID="UUJJNN"

# The port on which you want to run the server
export PORT=9000

# You can now start the server
npm start

# open a browser
open http://localhost:9000/

```

# Preparing your Content

Nothing is free my friend. You need to follow some rules.

## The Document Index

You need to pick one Document to use it as index. It will contain a list of all the docs you want to include
plus some metadata. Add the ID of this document to the `INDEX_DOC_ID` env var.

Here's an example: (TODO)

## Document Structure and Formatting

Any doc will work. But there are some tips and tricks that allow you to take advantage of some of
the nice features of the platform like the TOC, code formatting and highlighting, etc.

TODO: example doc.

# Running on Heroku

TODO


# FAQ

## How do I find a document's ID?

![Google Doc ID Screenshot](https://dl.dropboxusercontent.com/u/497895/__permalinks/google-doc-id.png)


The ID for the document above is **1JyF08cCVDC4dvZOQsrx8qeMQVvdRSUC0ziyEvX4wo44**


## What happens if Google changes the Document format?

Things will break. We will have to update the transformation heuristics.

## Do drawings an images work?

Yep. Everything does.





