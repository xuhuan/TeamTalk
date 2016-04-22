#!/bin/bash
#站点部署

deploy_web(){
	rm -rf tt.zip
	cp -r php tt
	zip -r tt.zip tt
	rm -rf tt 
}


print_help() {
	echo "Usage: "
	echo "  $0 web --- create tt.zip"
}

case $1 in
	web)
		print_hello $1
		deploy_web
		;;
	*)
		print_help
		;;
esac


