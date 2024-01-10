#!/bin/bash
###
# @Description: 执行安装acme.sh
# @Version:
# @Author: BaiYiZhuo
# @Date: 2023-09-14 14:53:02
# @LastEditTime: 2023-09-14 15:05:34
###
# 支持的provider : env name:['dns_ali','dns_cf','dns_dp']
# 对应dns的key与token请参照https://acme.sh 官方进行运行时候传入
# 检查证书是否已存在
echo '开始检查证书'
if [ ! -f "/etc/nginx/cert/$CERT_NAME.crt" ] || [ ! -f "/etc/nginx/cert/$CERT_NAME.key" ]; then
    echo "证书文件不存在,开始申请证书..."
    /root/.acme.sh/acme.sh --issue --dns $DNS_PROVIDER -d $DOMAIN_NAME --register-account $REGISTER_EMAIL
    /root/.acme.sh/acme.sh --installcert -d $DOMAIN_NAME --key-file /etc/nginx/cert/$CERT_NAME.key --fullchain-file /etc/nginx/cert/$CERT_NAME.crt --reloadcmd "service nginx force-reload"
else
    echo "证书文件已经安装了,不会在进行安装!"
fi

# 启动 Nginx
echo '开始启动nginx守护进程'

nginx -g "daemon off;"
