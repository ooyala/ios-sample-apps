package vendor_config

import "log"
import "mobile.ooyala.com/common/util"
import . "mobile.ooyala.com/common/path"

/**
 * This config file represents folders to access vendor files.
 * Consistent between Android and iOS sample app
 */
type Config struct {
	RootPath         DirAbs

	VendorFreewheelFolderPath DirAbs
	VendorIMAFolderPath DirAbs

	VendorOoyalaRootFolderPath DirAbs
	VendorOoyalaFreewheelFolderPath DirAbs
	VendorOoyalaIMAFolderPath DirAbs
	VendorOoyalaCoreFolderPath DirAbs

	OoyalaCoreSDKFilePaths []Pather
	IMASDKFilePaths []Pather
	FreewheelSDKFilePaths []Pather
}

func MakeiOSConfig(rootPath DirAbs, logger *log.Logger) Config {
	vendorDirName := MakeDirName("vendor")
	vendorPath := MakeDirAbs(Join(rootPath, vendorDirName))

	//Names of all folders in vendor
	freewheelDirName  := MakeDirName("Freewheel")
	googleDirName     := MakeDirName("Google")
	ooyalaDirName     := MakeDirName("Ooyala")
	ooyalaIMADirName  := MakeDirName("OoyalaIMASDK-iOS")
	ooyalaFWDirName   := MakeDirName("OoyalaFreewheelSDK-iOS")
	ooyalaCoreDirName := MakeDirName("OoyalaSDK-iOS")
	
	vendorFreewheelFolderPath := MakeDirAbs(Join(vendorPath, freewheelDirName))
	vendorIMAFolderPath       := MakeDirAbs(Join(vendorPath, googleDirName))

	vendorOoyalaRootFolderPath      := MakeDirAbs(Join(vendorPath, ooyalaDirName))
	vendorOoyalaFreewheelFolderPath := MakeDirAbs(Join(vendorPath, ooyalaDirName, ooyalaFWDirName))
	vendorOoyalaIMAFolderPath       := MakeDirAbs(Join(vendorPath, ooyalaDirName, ooyalaIMADirName))
	vendorOoyalaCoreFolderPath      := MakeDirAbs(Join(vendorPath, ooyalaDirName, ooyalaCoreDirName))

	c := Config {
		RootPath: rootPath,

		VendorFreewheelFolderPath:       vendorFreewheelFolderPath,
		VendorIMAFolderPath:             vendorIMAFolderPath,

		VendorOoyalaRootFolderPath:      vendorOoyalaRootFolderPath,	
		VendorOoyalaFreewheelFolderPath: vendorOoyalaFreewheelFolderPath,
		VendorOoyalaIMAFolderPath:       vendorOoyalaIMAFolderPath,
		VendorOoyalaCoreFolderPath:      vendorOoyalaCoreFolderPath,

		OoyalaCoreSDKFilePaths:      []Pather{},

		IMASDKFilePaths:       []Pather{},

		FreewheelSDKFilePaths: []Pather{},
	}
	util.RequireFullStructOrDie(c, logger)
	return c
}
