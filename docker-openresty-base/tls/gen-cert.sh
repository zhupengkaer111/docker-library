#!/bin/bash
echo "使用方式: ./gen-cert.sh key-name [length] (默认长度为2048)"
KEY_NAME=$1
RSA_LEN=$2
function isKeyNameVaild()
{
	local key_name=$KEY_NAME
	if [ ! $key_name ]; then
		echo 0
	else
		echo 1
	fi

}
if [ ! $KEY_NAME ]; then
	while [[ `isKeyNameVaild` == 0 ]]
	do
		read -p "请输入证书名字:" KEY_NAME
	done
fi
if [ ! $RSA_LEN ]; then
	RSA_LEN=2048
fi
DST_DIR="${KEY_NAME}-cert"
CUR_DIR=`pwd`
if [ ! -d $DST_DIR ]; then
	sudo mkdir $DST_DIR 
fi
cd $DST_DIR 
openssl genrsa -des3 -out "${KEY_NAME}.key" $RSA_LEN
openssl rsa -in "${KEY_NAME}.key" -out "${KEY_NAME}.key.unsecure"
openssl req -new -key "${KEY_NAME}.key" -out "${KEY_NAME}.csr"
openssl x509 -req -days 365 -in "${KEY_NAME}.csr" -signkey "${KEY_NAME}.key" -out "${KEY_NAME}.crt"
#生成CA证书
sudo openssl genrsa -out "${KEY_NAME}-ca-key.pem" $RSA_LEN
sudo openssl req -new -key "${KEY_NAME}-ca-key.pem" -out "${KEY_NAME}-ca-req.csr" -subj "/C=CN/ST=BJ/L=BJ/O=fish/OU=fish/CN=CA"
sudo openssl x509 -req -in "${KEY_NAME}-ca-req.csr" -out "${KEY_NAME}-ca-cert.pem" -signkey "${KEY_NAME}-ca-key.pem" -days 3650
#生成服务器证书
sudo openssl genrsa -out "${KEY_NAME}-server-key.pem" $RSA_LEN
sudo sleep 1
sudo openssl req -new -out "${KEY_NAME}-server-req.csr" -key "${KEY_NAME}-server-key.pem" -subj "/C=CN/ST=BJ/L=BJ/O=fish/OU=fish/CN=*.*.com"
sudo sleep 1
sudo openssl x509 -req -in "${KEY_NAME}-server-req.csr" -out "${KEY_NAME}-server-cert.pem" -signkey "${KEY_NAME}-server-key.pem" -CA "${KEY_NAME}-ca-cert.pem" -CAkey "${KEY_NAME}-ca-key.pem" -CAcreateserial -days 3650
sudo openssl verify -CAfile "${KEY_NAME}-ca-cert.pem"  "${KEY_NAME}-server-cert.pem"
#生成客户端证书
sudo openssl genrsa -out "${KEY_NAME}-client-key.pem" $RSA_LEN
sudo openssl req -new -out "${KEY_NAME}-client-req.csr" -key "${KEY_NAME}-client-key.pem" -subj "/C=CN/ST=BJ/L=BJ/O=fish/OU=fish/CN=dong"
sudo openssl x509 -req -in "${KEY_NAME}-client-req.csr" -out "${KEY_NAME}-client-cert.pem" -signkey "${KEY_NAME}-client-key.pem" -CA "${KEY_NAME}-ca-cert.pem" -CAkey "${KEY_NAME}-ca-key.pem" -CAcreateserial -days 3650
sudo openssl verify -CAfile "${KEY_NAME}-ca-cert.pem" "${KEY_NAME}-client-cert.pem"
cd $CUR_DIR
