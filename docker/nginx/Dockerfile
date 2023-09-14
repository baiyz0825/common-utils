FROM nginx:stable-bullseye

LABEL maintainer="byz0825@outlook.com"
# 安装依赖文件
# 更换 APT 源为 mirrors.ustc.edu.cn
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y curl socat net-tools vim cron
# 安装 acme.sh
RUN curl https://get.acme.sh | sh

COPY conf/ /etc/nginx/
COPY cert/ /etc/nginx/cert

# 拷贝执行脚本
COPY ./start.sh /usr/local/app/
RUN chmod +x /usr/local/app/start.sh

# 暴露端口
EXPOSE 80
EXPOSE 443
# 设置入口点
ENTRYPOINT ["/usr/local/app/start.sh"]