export GOPATH = $(shell pwd)/go_script/

install: install-scripts


clean-scripts:
	rm -f go_script/bin/*

install-scripts: clean-scripts
	cd go_script/src/mobile.ooyala.com/samples/ios/update_from_target_location/ && go install

update-from-target-location: install-scripts
	go_script/bin/update_from_target_location -path=$(path)
