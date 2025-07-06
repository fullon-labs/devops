## Step-1: Enter PG database manager to do soft/logical deletion

## Step-2: Enter PostgreSQL container
`dex $pg_container bash`

## Step-3: Execute the following to apply hard deletion

```
cd /var/lib/postgresql/data/pgdata
WAL=$(pg_controldata $PGDATA |grep "Latest checkpoint's REDO WAL file" | cut -d ':' -f2)
pg_archivecleanup -d ./pg_wal/ $WAL
exit
```
