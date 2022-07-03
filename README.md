# 本仓库是什么？
PC网站反爬demo，适合部署在openresty开发的api网关上。

支持：
* 对用户指定的api防爬、防扫
* 对图片做防爬

# 快速开始
参考 examples/openresty/README.md

快速启动测试服务后，按照文档测试反爬效果
 ```
 docker run -ti --rm --name anti-spider-demo -p 8088:80 -p 8089:8080 leveryd/antispider bash
 openresty
 ```

# TODO
* [ ] 增加"代理识别"
* [ ] 增加"TLS指纹识别"
* [ ] 增加"验证码识别"
* [ ] 优化"代码混淆"
* [ ] 优化"行为分析"

# 文章
[反爬检测小结(1)](https://mp.weixin.qq.com/s/g7Dyo3VD7I8h99IulJNGXw)

# 联系作者
微信: happy_leveryd <br>
邮箱: leveryd@gmail.com