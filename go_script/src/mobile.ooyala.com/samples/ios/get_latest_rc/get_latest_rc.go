package main
import ol "mobile.ooyala.com/common/log"
import "log"
import "mobile.ooyala.com/common/util"
import . "mobile.ooyala.com/common/path"
import vc "mobile.ooyala.com/samples/config/vendor_config"
import zc "mobile.ooyala.com/samples/config/zip_config"

func main() {
	l, err := ol.NewFileAndStdoutLoggerNow(MakeFileAbs("/tmp/android-sample-apps.get_latest_rc"))
	ol.ColorizedPrintln(l, "GetLatestRc")
	util.MaybeDie(err, nil)

	rootDir, err := util.ToDirAbs(MakeDirRel("."))
	util.MaybeDie(err, l)

	config := vc.MakeiOSConfig(rootDir, l);
	zipConfig := zc.MakeiOSConfig(rootDir, l);

	removeOldOoyalaVendorFolders(config, l)

	downloadNewRCPackages(config, zipConfig, l)

	unzipNewRCPackages(config, zipConfig, l)

	removeZipFiles(config, zipConfig, l)

	//TEMPORARY: Remove all sample apps provided in the packages, until the sample apps are no longer included
	util.DeletePath(MakeFileAbs(Join(config.VendorOoyalaCoreFolderPath, MakeFileName("SampleApps"))), l);
	util.DeletePath(MakeFileAbs(Join(config.VendorOoyalaCoreFolderPath, MakeFileName("APIDocs"))), l);
	util.DeletePath(MakeFileAbs(Join(config.VendorOoyalaFreewheelFolderPath, MakeFileName("FreewheelSampleApp"))), l);
	util.DeletePath(MakeFileAbs(Join(config.VendorOoyalaFreewheelFolderPath, MakeFileName("APIDocs"))), l);
	util.DeletePath(MakeFileAbs(Join(config.VendorOoyalaIMAFolderPath,MakeFileName("IMASampleApp"))), l);
	util.DeletePath(MakeFileAbs(Join(config.VendorOoyalaIMAFolderPath, MakeFileName("APIDocs"))), l);
}

func removeOldOoyalaVendorFolders(config vc.Config, l *log.Logger) {
	ol.ColorizedMethodPrintln(l)
		util.DeletePath(config.VendorOoyalaFreewheelFolderPath, l);
		util.DeletePath(config.VendorOoyalaCoreFolderPath, l);
		util.DeletePath(config.VendorOoyalaIMAFolderPath, l);
}

func downloadNewRCPackages(config vc.Config, zipConfig zc.Config, l *log.Logger) {
	ol.ColorizedMethodPrintln(l)
	err := util.RunBashCommandsInDir(config.VendorOoyalaRootFolderPath, []string{"wget '" + zipConfig.CoreSDKCandidateURL + "' --progress=bar -O " + zipConfig.CoreSDKFileNameStr}, l)
	util.MaybeDie(err, l)

	err = util.RunBashCommandsInDir(config.VendorOoyalaRootFolderPath, []string{"wget '" + zipConfig.FreewheelSDKCandidateURL + "' --progress=bar -O " + zipConfig.FreewheelSDKFileNameStr}, l)
	util.MaybeDie(err, l)

	err = util.RunBashCommandsInDir(config.VendorOoyalaRootFolderPath, []string{"wget '" + zipConfig.IMASDKCandidateURL + "' --progress=bar -O " + zipConfig.IMASDKFileNameStr}, l)
	util.MaybeDie(err, l)
}


func unzipNewRCPackages(config vc.Config, zipConfig zc.Config, l *log.Logger) {
	ol.ColorizedMethodPrintln(l)
	err := util.RunBashCommandsInDir(config.VendorOoyalaRootFolderPath, []string{"unzip " + zipConfig.CoreSDKFileNameStr}, l)
	util.MaybeDie(err, l)

	err = util.RunBashCommandsInDir(config.VendorOoyalaRootFolderPath, []string{"unzip " + zipConfig.FreewheelSDKFileNameStr}, l)
	util.MaybeDie(err, l)

	err = util.RunBashCommandsInDir(config.VendorOoyalaRootFolderPath, []string{"unzip " + zipConfig.IMASDKFileNameStr}, l)
	util.MaybeDie(err, l)
}

func removeZipFiles(config vc.Config, zipConfig zc.Config, l *log.Logger) {
	ol.ColorizedMethodPrintln(l)
	err := util.RunBashCommandsInDir(config.VendorOoyalaRootFolderPath, []string{"rm " + zipConfig.CoreSDKFileNameStr}, l)
	util.MaybeDie(err, l)

	err = util.RunBashCommandsInDir(config.VendorOoyalaRootFolderPath, []string{"rm " + zipConfig.FreewheelSDKFileNameStr}, l)
	util.MaybeDie(err, l)

	err = util.RunBashCommandsInDir(config.VendorOoyalaRootFolderPath, []string{"rm " + zipConfig.IMASDKFileNameStr}, l)
	util.MaybeDie(err, l)
}