* build docker image

  under `antispider` root directory

    ```
    docker build -t leveryd/antispider -f examples/openresty/Dockerfile .
    ```

* start service

    ```
    docker run -ti --rm --name anti-spider-demo -p 8088:80 -p 8089:8080 leveryd/antispider openresty
    ```