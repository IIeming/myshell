#!/bin/bash
#安装必要的工具
yum install vim -y
yum install autofs -y
yum install lrzsz -y
yum install bash-completion -y
yum install net-tools-2.0-0.24.20131004git.el7.x86_64 -y
systemctl start autofs
systemctl enable autofs
#关闭防火墙
systemctl stop firewalld.service
systemctl disable firewalld.service
#设置yum源
echo "设置yum源"
cat >/etc/yum.repos.d/base.repo <<EOF
[base]
name=base
baseurl=file:///misc/cd
gpgcheck=0
enabled=1
[epel]
name=epel
baseurl=https://mirrors.aliyun.com/epel/7/x86_64/
gpgcheck=0 
enabled=1
EOF
#设置PS1颜色
echo "设置PS1颜色"
echo 'PS1="\[\e[1;34m\][\u@\h \W]\\$\[\e[0m\]"'  > /etc/profile.d/env.sh
source /etc/profile.d/env.sh
#禁用selinux
echo "禁用selinux"
setenforce 0
sed -i 's@^\(SELINUX=\).*@\1disabled@' /etc/selinux/config
echo -e "\e[1;31m是否重启服务器\e[0m"
select lemon in "yes" "no" "exit" ; do
    if [[ ${lemon} == "yes" ]] ;then
        reboot
    elif [[ ${lemon} == "exit" ]] ;then
        exit
    else
        exit
    fi
    echo "初始化结束，建议重启服务器"
done
