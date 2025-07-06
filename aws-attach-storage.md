## steps to mount a storage
```
sudo mkfs -t xfs /dev/nvme1n1

sudo mkdir /opt/mgp

sudo mount /dev/nvme1n1 /opt/mgp

```

## to mount it upon boot automatically

### get device UUID

```
sudo blkid
```

### edit /etc/fstab by appending the following line

```
UUID=e873f844-a2bb-4ed6-9e79-f3355d6157da  /opt/mgp  xfs  defaults,nofail  0  2
```

## unmount and amount

```
sudo umount /opt/mgp
sudo mount -a
```