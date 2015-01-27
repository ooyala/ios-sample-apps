export GOPATH = $(shell pwd)/go_script/

install: install-scripts

get-latest-rc: install-scripts
	go_script/bin/get_latest_rc

clean-scripts:
	rm -f go_script/bin/*

install-scripts: clean-scripts
	cd go_script/src/mobile.ooyala.com/samples/ios/get_latest_rc/ && go install
	cd go_script/src/mobile.ooyala.com/samples/ios/get_latest_release/ && go install

clean: install-scripts
	go_script/bin/clean_sample_apps
