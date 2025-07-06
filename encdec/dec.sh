openssl enc -d -aes-256-cbc -in $1 -out $1.dec.txt -pass pass:$2
