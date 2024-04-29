# supabase
# Docker Pull
docker pull supabase/studio:20240415-304bec8 --platform=linux/amd64
docker pull kong:2.8.1 --platform=linux/amd64
docker pull postgrest/postgrest:v12.0.1 --platform=linux/amd64
docker pull supabase/storage-api:v1.0.10 --platform=linux/amd64
docker pull supabase/postgres-meta:v0.80.0 --platform=linux/amd64
docker pull supabase/postgres:15.1.0.147 --platform=linux/amd64

# mkdir deploy
docker save supabase/studio:20240415-304bec8 | gzip > ./supabase/deploy/images/supabase-studio:20240415-304bec8.tar.gz
docker save kong:2.8.1 | gzip > ./supabase/deploy/images/kong:2.8.1.tar.gz
docker save postgrest/postgrest:v12.0.1 | gzip > ./supabase/deploy/images/postgrest-postgrest:v12.0.1.tar.gz
docker save supabase/storage-api:v1.0.10 | gzip > ./supabase/deploy/images/supabase-storage-api:v1.0.10.tar.gz
docker save supabase/postgres-meta:v0.80.0 | gzip > ./supabase/deploy/images/supabase-postgres-meta.tar.gz
docker save supabase/postgres:15.1.0.147 | gzip > ./supabase/deploy/images/supabase-postgres:15.1.1.42.tar.gz

# Dev
scp -r ./supabase/deploy dev_rocky:~/my_project/supabase/
scp ./supabase/.env dev_rocky:~/my_project/supabase
scp ./supabase/docker-compose.yml dev_rocky:~/my_project/supabase
scp ./supabase/volumes/api/kong.yml dev_rocky:~/my_project/supabase/volumes/api/