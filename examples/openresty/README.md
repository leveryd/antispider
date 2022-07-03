# 防护效果

启动测试服务后，浏览器中可以正常访问"防护接口"(default.conf配置的`^/api/user`)

![img](https://user-images.githubusercontent.com/1846319/177007980-ab9e6795-acc0-496b-9ce8-a990251430de.png)

使用curl(其他客户端工具)或者浏览器直接访问接口，均会被拦截

![img](https://user-images.githubusercontent.com/1846319/177008040-4e61b210-da0d-437c-9c66-2fa086de4186.png)

关闭防护后，使用curl(其他客户端工具)或者浏览器直接访问接口，均不会被拦截

# 简要的帮助文档
* 怎么构建"测试服务"镜像？

  在 `antispider` 项目根目录下，执行如下命令
  ```
  docker build -t leveryd/antispider -f examples/openresty/Dockerfile .
  ```

* 怎么管理测试服务？

  启动服务
  ```
  docker run -ti --rm --name anti-spider-demo -p 8088:80 -p 8089:8080 leveryd/antispider bash
  openresty
  ```

  重启服务
  ```
  openresty -s reload
  ```

* 怎么关闭反爬防护？

  修改 config.lua `enable=false` 后，重启服务