


```shell

# clone and install
git clone https://github.com/aldonline/driven.git
cd driven
npm install -d


# set some env vars
export CLIENT_ID="XXYYZZ.apps.googleusercontent.com"
export CLIENT_SECRET="XXYYZZ"
export REDIRECT_URL="http://localhost/auth/google/redirect"
export MONGO_URL="mongodb://user:passwor@foo.mongohq.com:10063/database-name"
export INDEX_ID="UUJJNN"
export PORT=9000


# start the server
npm start


# open a browser
open http://localhost:9000/


```