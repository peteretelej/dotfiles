#!/bin/bash

function proxyset() {
	if [[ "$1" = "http"* ]]
	then 
		echo "proxyset requires a valid http addr"
		exit 2
	fi

	export {http,https,ftp}_proxy=$1
}
function proxyunset(){
	unset {http,https,ftp}_proxy
}
