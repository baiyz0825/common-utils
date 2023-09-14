<!--
 * @Description: 
 * @Version: 
 * @Author: BaiYiZhuo
 * @Date: 2023-09-14 15:30:36
 * @LastEditTime: 2023-09-14 16:39:28
-->
# 使用说明
本镜像是对官网Nginx镜像的二次打包,安装了必要网络工具socat、net-tools、vim等... 并且预定安装了**acme.sh** 方便进行证书的申请(acme见官方文档[acmeDoc](https://github.com/acmesh-official/acme.sh))<br>
> acme使用方法参考: [使用acme自动申请CA证书](https://blog.baiyz.top/posts/bb356855/?highlight=acme)

---
# 默认使用
- 容器启动调用start.sh进行启动
- 默认暴露80 443端口

# 环境变量含义
|环境变量名称|是否必传|参数值示例|
|---|---|---|
|CERT_NAME|yes|mydomain_cert_name|
|DNS_PROVIDER|yes|['dns_ali','dns_cf','dns_dp']|
|DOMAIN_NAME|yes|['youdomain.com','*.yourdomain.com']|

# 示例
## Dcoker run 
```sh
docker run -d \
  -e CERT_NAME=your_cert_name \
  -e DNS_PROVIDER=your_dns_provider \
  -e DOMAIN_NAME=domain_name \
  -v ./你的配置文件路径/:/etc/nginx/  \
  -p 80:80 \
  -p 443:443 \
  ghcr.io/baiyz0825/docker-project/nginx:latest
```
## Docker Compose
```yaml
version: '3'
services:
  my_service:
    image: ghcr.io/baiyz0825/docker-project/nginx:latest
    environment:
      - CERT_NAME=your_cert_name
      - DNS_PROVIDER=your_dns_provider
      - DOMAIN_NAME=domain_name
    volumes:
      - ./你的配置文件路径/:/etc/nginx      
    ports:
      - 80:80
      - 443:443
```
> 注意这里需哟注意请提前在自己文件夹中创建下面的nginx.conf文件

"你的配置文件路径"的目录结构如下:
```txt
.
├── nginx.conf
└── vhost
```
示例配置文件:

```conf
user  nginx;
worker_processes  auto;
error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;
events {
    worker_connections  1024;
}
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile        on;
    #tcp_nopush     on;
    keepalive_timeout  65;
    gzip  on;
    # 这里为vhost文件夹
    include /etc/nginx/vhost/*.conf;
}

```