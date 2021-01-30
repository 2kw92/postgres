# postgres
Дз Отус по Теме Postgresql

Для проверки дз необходимо запустить Vagrantfile,который развернт всю необходимую
инфраструктуру. Написаны необходимы роли на ansible.

Далее заходим на мастер и выполняем:       
```
ansible-playbook -i /vagrant/hosts /vagrant/postgres.yml
```       
Там будет проблема с последнем таском необходимо будет от имени barman:        
еще раз выполнить:
```
-bash-4.2$ barman switch-xlog --force --archive master
The WAL file 000000010000000000000004 has been closed on server 'master'
Waiting for the WAL file 000000010000000000000004 from server 'master' (max: 30 seconds)
Processing xlog segments from streaming for master
        000000010000000000000004
```

Далее от от имени         
postgres заходим в psql и выполняем:           
```
[root@master ansible]# su postgres
bash-4.2$ psql
psql (11.10)
Type "help" for help.

postgres=# SELECT * FROM pg_replication_slots \gx
-[ RECORD 1 ]-------+----------
slot_name           | replica
plugin              |
slot_type           | physical
datoid              |
database            |
temporary           | f
active              | t
active_pid          | 7065
xmin                |
catalog_xmin        |
restart_lsn         | 0/3000060
confirmed_flush_lsn |

postgres=# SELECT * FROM pg_stat_replication \gx
-[ RECORD 1 ]----+------------------------------
pid              | 7065
usesysid         | 16384
usename          | replica
application_name | walreceiver
client_addr      | 192.168.50.2
client_hostname  |
client_port      | 35748
backend_start    | 2021-01-29 07:56:25.463432+00
backend_xmin     |
state            | streaming
sent_lsn         | 0/3000060
write_lsn        | 0/3000060
flush_lsn        | 0/3000060
replay_lsn       | 0/3000060
write_lag        |
flush_lag        |
replay_lag       |
sync_priority    | 0
sync_state       | async

```         

Видим что все с репликой ок

Проверяем barman:        
```
-bash-4.2$ barman switch-xlog --force --archive master
-bash-4.2$ barman check master
Server master:
        PostgreSQL: OK
        superuser or standard user with backup privileges: OK
        PostgreSQL streaming: OK
        wal_level: OK
        replication slot: OK
        directories: OK
        retention policy settings: OK
        backup maximum age: OK (no last_backup_maximum_age provided)
        compression settings: OK
        failed backups: OK (there are 0 failed backups)
        minimum redundancy requirements: OK (have 0 backups, expected at least 0)
        pg_basebackup: OK
        pg_basebackup compatible: OK
        pg_basebackup supports tablespaces mapping: OK
        systemid coherence: OK (no system Id stored on disk)
        pg_receivexlog: OK
        pg_receivexlog compatible: OK
        receive-wal running: OK
        archive_mode: OK
        archive_command: OK
        continuous archiving: OK
        archiver errors: OK
```        
Видим что все ок  