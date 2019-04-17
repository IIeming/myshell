#!/bin/bash
#注意事项:如果报错说没有arp命令的话,需要
#yum  install   net-tools-2.0-0.24.20131004git.el7.x86_64
#如果查询的虚拟主机,没有返回数据,可能是虚拟机配置有问题,没有生成ip地址
#2019_4_17  
kvm_hanshu () {
case  $name  in
exit)
        echo $name
        exit
        ;;
$name)
        mac=`virsh dumpxml $name |grep -w mac |awk -F "'" '{print $2}'`
        echo "虚拟机$name,的ip地址是:`arp -a |grep $mac | awk -F"[()]" '{print $2}'` "
        ;;
esac
}
########
echo  "请选择要查询的虚拟机名称"
select  name in `virsh list |awk -F" " '{print $2}'|grep -v "Name" |sort |uniq -u ` "exit" ; do
kvm_hanshu
done
