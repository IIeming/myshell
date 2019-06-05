read -p "请输入班级人数:" num
PS3="继续请选择1,退出选择2,请输入:"
randoms() {
random=`seq $num | sort -R |head -n 1`
lucky=`echo -e "恭喜\e[1;31m${random}\e[0m号同学中奖"`
echo $lucky
select ha in "继续" "退出" ;do
    if [ $ha == "继续" ] ;then
        randoms
    else
        exit
    fi
done
}
while true ;do
    randoms
done 
