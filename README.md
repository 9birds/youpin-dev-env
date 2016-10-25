# youpin-env
优聘开发环境



# 构建 
~$ docker build -t="youpin/ubuntu-nginx:v7" .


# 运行
~$ docker run -d -p 80 --name nginx-v7 -v "D:\git_repo\home\data\www":/home/data/www youpin/ubuntu-nginx:v7 nginx




