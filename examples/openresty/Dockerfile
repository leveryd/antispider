FROM openresty/openresty:latest

COPY lua/* /usr/local/openresty/lualib/
COPY lua/rsa.lua /usr/local/openresty/lualib/resty/

# 网关配置、api接口
COPY examples/openresty/default.conf /etc/nginx/conf.d/default.conf

# 前端资源
COPY examples/openresty/fronted /usr/local/openresty/nginx/html/

# 用户反爬配置
COPY examples/openresty/config.lua /usr/local/openresty/lualib/
