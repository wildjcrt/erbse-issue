# How to run

```
$ bundle install
$ ruby app.rb # normal return
$ ruby error.rb # Prove that Erbse doesn't support case…when… statement.
```

# If you wanna use docker

## Start docker

### Install Docker Desktop

Only for the first time.

  ```shell
  $ brew install --cask docker
  ```

### docker-sync and docker-compose

$ gem i docker-sync
$ docker-sync start
$ docker-compose up

## Stop docker

$ docker-compose down
$ docker-sync stop
