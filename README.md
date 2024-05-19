# Self-Hosting-Supabase-Storage

https://github.com/orgs/supabase/discussions/23408

### Situation

I'm trying to get docker images pulled from my MacBook and send them to a remote server.
Since the remote server is not connected to Wi-Fi, I use the method of connecting to the scp connection and transmitting pulled docker images.

### Configuration

Local (Images pull) : Apple intel chip
Remote Server (received Images) : Rocky Linux

### How to fix the error

[1] (Important) Pull images that fits the OS/CPU of the remote server

```shell
docker pull supabase/studio:20240415-304bec8 --platform=linux/amd64
docker pull kong:2.8.1 --platform=linux/amd64
docker pull postgrest/postgrest:v12.0.1 --platform=linux/amd64
docker pull supabase/storage-api:v1.0.10 --platform=linux/amd64
docker pull supabase/postgres-meta:v0.80.0 --platform=linux/amd64
docker pull supabase/postgres:15.1.0.147 --platform=linux/amd64
```

**If you do not set the platform here for the remote server, the `kong.yml` file is not created!! When you `docker compose up -d --build`, a directory named `kong.yml` is created!!**

<img width="380" alt="image" src="https://github.com/supabase/supabase/assets/81238093/4dfadcde-43d6-4a2b-a67a-2c2367c2a677">

**You'll see this error messages!!**
```shell
2024/04/08 07:38:01 [error] 1#0: init_by_lua error: /usr/local/share/lua/5.1/kong/init.lua:553: error parsing declarative config file /home/kong/kong.yml:
failed parsing declarative configuration: expected an object
stack traceback:
	[C]: in function 'error'
	/usr/local/share/lua/5.1/kong/init.lua:553: in function 'init'
	init_by_lua:3: in main chunk
nginx: [error] init_by_lua error: /usr/local/share/lua/5.1/kong/init.lua:553: error parsing declarative config file /home/kong/kong.yml:
failed parsing declarative configuration: expected an object
```

[2] (Optional) Compress images

```shell
docker save supabase/studio:20240415-304bec8 | gzip > ./supabase/deploy/images/supabase-studio:20240415-304bec8.tar.gz
docker save kong:2.8.1 | gzip > ./supabase/deploy/images/kong:2.8.1.tar.gz
docker save postgrest/postgrest:v12.0.1 | gzip > ./supabase/deploy/images/postgrest-postgrest:v12.0.1.tar.gz
docker save supabase/storage-api:v1.0.10 | gzip > ./supabase/deploy/images/supabase-storage-api:v1.0.10.tar.gz
docker save supabase/postgres-meta:v0.80.0 | gzip > ./supabase/deploy/images/supabase-postgres-meta.tar.gz
docker save supabase/postgres:15.1.0.147 | gzip > ./supabase/deploy/images/supabase-postgres:15.1.1.42.tar.gz
```

[3] Send compressed Images && `.env` && `docker-compose.yml`

```shell
scp -r ./supabase/deploy dev_rocky:~/my_project/supabase/
scp ./supabase/.env dev_rocky:~/my_project/supabase
scp ./supabase/docker-compose.yml dev_rocky:~/my_project/supabase
```

[4] Access the remote server, and up received Images

```shell
docker compose up -d --build
```

### Full code to help

- [Full code included [1] [2] [3] (Send proper Images to remote server)](https://github.com/RumosZin/Self-Hosting-Supabase-Storage/blob/main/build_dev.sh)

- [Full code included [4] (upzip compressed Images and up Images)](https://github.com/RumosZin/Self-Hosting-Supabase-Storage/tree/main/deploy)
