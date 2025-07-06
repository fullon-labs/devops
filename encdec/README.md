## encrypt a tarball file

```shell
$ ls
archive_file.tar file1.txt file2.txt file3.txt
$ gpg --symmetric --cipher-algo aes256 archive_file.tar 
$ ls
archive_file.tar archive_file.tar.gpg file1.txt file2.txt file3.txt
```


## decrypt an encrypted tarball file

```shell
$ gpg --output archive_file.tar --decrypt archive_file.tar.gpg 
gpg: AES256 encrypted data
gpg: encrypted with 1 passphrase
$ ls
archive_file.tar archive_file.tar.gpg file1.txt file2.txt file3.txt
```
