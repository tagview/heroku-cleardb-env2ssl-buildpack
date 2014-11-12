Add the ClearDB SSL Certs to your ENV Variables instead of including them in the project.

Usage:

1. Download the ClearDB SSL Certificates (ClearDB CA Certificate, Client Certificate, Client Private Key)
2. Remove the client PK certificate password:

   ```
   openssl rsa -in cleardb_id-key.pem -out cleardb_id-key-no-password.pem
   ```
3. Delete cleardb_id-key.pem *just for ensure you will not use this cert*:

   ```
   rm cleardb_id-key.pem
   ```
4. Place the certs inside the vars in Heroku:

   ```
   heroku config:set CLEARDB_SSL_CA_CERT="$(cat cleardb-ca.pem)"
   heroku config:set CLEARDB_SSL_CLI_CERT="$(cat cleardb_id-cert.pem)"       # Replace cleardb_id with your cleard id.
   heroku config:set CLEARDB_SSL_KEY="$(cat cleardb_id-key-no-password.pem)" # Replace cleardb_id with your cleard id.
   ```
5. Add the following params to Heroku $DATABASE_URL:
   *Do not replace the cleardb with your id here*
   - `sslca=cleardb-ca-cert.pem`
   - `sslcert=cleardb-cert.pem`
   - `sslkey=cleardb-key.pem` 
   
   If your DATABASE_URL is:

   ```
   mysql2://1234567890:1234567890@us-cdbr-east-00.cleardb.net/heroku_1234567890?reconnect=true
   ```
   It should stay: 
   *Again: Do NOT replace the cleardb with your id here*

   ```
   mysql2://1234567890:1234567890@us-cdbr-east-00.cleardb.net/heroku_1234567890?reconnect=true&sslca=cleardb-ca-cert.pem&sslcert=cleardb-cert.pem&sslkey=cleardb-key.pem
   ```

   You can do this just by running:

   ```
   heroku config:set DATABASE_URL="$(heroku config:get DATABASE_URL)&sslca=cleardb-ca-cert.pem&sslcert=cleardb-cert.pem&sslkey=cleardb-key.pem"
   ```

5. Delete the certs you downloaded and created.
6. Add *https://github.com/tagview/heroku-cleardb-env2ssl-buildpack* to your .buildpacks
7. Deploy the app to heroku.
