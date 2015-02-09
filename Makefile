export GOPATH = $(shell pwd)/go_script/

install: install-scripts

get-latest-rc: install-scripts
	go_script/bin/get_latest_rc

get-latest-release: install-scripts
	go_script/bin/get_latest_release

clean-scripts:
	rm -f go_script/bin/*

install-scripts: clean-scripts
	cd go_script/src/mobile.ooyala.com/samples/ios/get_latest_rc/ && go install
	cd go_script/src/mobile.ooyala.com/samples/ios/get_latest_release/ && go install
	cd go_script/src/mobile.ooyala.com/samples/ios/update_from_target_location/ && go install

update-from-target-location:
	go_script/bin/update_from_target_location -path=/Users/yigu/repos/ios-sdk/
