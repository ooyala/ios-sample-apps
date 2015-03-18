package zip_config

import "log"
import "mobile.ooyala.com/common/util"
import . "mobile.ooyala.com/common/path"

/**
 * This config file represents folders to access vendor files.
 * Consistent between Android and iOS sample app
 */
type Config struct {
	RootPath         DirAbs

	CoreSDKFileName		    FileName
	FreewheelSDKFileName	FileName
	IMASDKFileName          FileName

	CoreSDKCandidateURL      string
	FreewheelSDKCandidateURL string
	IMASDKCandidateURL       string

	CoreSDKURL      string
	FreewheelSDKURL string
	IMASDKURL       string
}


func MakeiOSConfig(rootPath DirAbs, logger *log.Logger) Config {
	ooyalaIMADirName  := MakeDirName("OoyalaIMASDK-iOS")
	ooyalaFWDirName   := MakeDirName("OoyalaFreewheelSDK-iOS")
	ooyalaCoreDirName := MakeDirName("OoyalaSDK-iOS")


	c := Config {
		RootPath: rootPath,


		IMASDKFileName:                 MakeFileName(ooyalaCoreDirName.S + ".zip"),
		FreewheelSDKFileName:           MakeFileName(ooyalaFWDirName.S + ".zip"),
		CoreSDKFileName:                MakeFileName(ooyalaIMADirName.S + ".zip"),

		CoreSDKCandidateURL:             "https://ooyala.box.com/shared/static/gs38fwznlseia502342j.zip",
		FreewheelSDKCandidateURL:        "https://ooyala.box.com/shared/static/opgc8csoav78ethzf47e.zip",
		IMASDKCandidateURL:              "https://ooyala.box.com/shared/static/ad1p8b2w82x4kgwmc62s.zip",

		CoreSDKURL:                      "https://ooyala.box.com/shared/static/trtptb6942ikglrdeq5e.zip",
		FreewheelSDKURL:                 "https://ooyala.box.com/shared/static/yx9lnfj19v6hgzaach5u.zip",
		IMASDKURL:                       "https://ooyala.box.com/shared/static/13to4ii3o3pgpzjvlaep.zip",
	}
	util.RequireFullStructOrDie(c, logger)
	return c
}


func MakeAndroidConfig(platformName string, rootPath DirAbs, logger *log.Logger) Config {
	ooyalaIMADirName  := MakeDirName("OoyalaIMASDK-Android")
	ooyalaFWDirName   := MakeDirName("OoyalaFreewheelSDK-Android")
	ooyalaCoreDirName := MakeDirName("OoyalaSDK-Android")


	c := Config {
		RootPath: rootPath,

		IMASDKFileName:                 MakeFileName(ooyalaCoreDirName.S + ".zip"),
		FreewheelSDKFileName:           MakeFileName(ooyalaFWDirName.S + ".zip"),
		CoreSDKFileName:                MakeFileName(ooyalaIMADirName.S + ".zip"),

		CoreSDKCandidateURL:             "https://ooyala.box.com/shared/static/inodnnnxaq3fwnzhid44.zip",
		FreewheelSDKCandidateURL:        "https://ooyala.box.com/shared/static/cmbyzhg8gxh3mqhaiv5c.zip",
		IMASDKCandidateURL:              "https://ooyala.box.com/shared/static/rludn8jljngyph7t3ukp.zip",

		CoreSDKURL:                      "https://ooyala.box.com/shared/static/90wup42cbi7ywel2all2.zip",
		FreewheelSDKURL:                 "https://ooyala.box.com/shared/static/i17ps4vjmne3bsnnc9sz.zip",
		IMASDKURL:                       "https://ooyala.box.com/shared/static/j1189d1o59t3sdaony7l.zip",

	}
	util.RequireFullStructOrDie(c, logger)
	return c
}
