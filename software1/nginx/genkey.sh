#1 gen key
openssl genrsa -des3 -out server.key 2048
#2 gen csr
openssl req -new -key server.key -out server.csr
	#CN
	#Beijing
	#Beijing
	#org
	#unit
	#name
	#email
#3 remove password
cp server.key server.key.org
openssl rsa -in server.key.org -out server.key
#4 sign
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
