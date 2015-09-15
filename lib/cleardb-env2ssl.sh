copy_from_env() {
  echo $1 > $2
}

cd $HOME
copy_from_env CLEARDB_SSL_CA_CERT cleardb-ca-cert.pem
copy_from_env CLEARDB_SSL_CLI_CERT cleardb-cert.pem
copy_from_env CLEARDB_SSL_KEY cleardb-key.pem
