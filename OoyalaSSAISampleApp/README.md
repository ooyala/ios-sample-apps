# Ooyala SSAI SDK. Integration for iOS

This project demonstrates a simple video player that displays content using the Ooyala Player while displaying ads using Ooyala SSAI.

This project is a sample intended **only** to give a brief introduction to the Ooyala SSAI SDK and help developers get started with their iOS integration.

This is absolutely **not** intended to be used in production or to outline best practices, but rather a simplified way of developing your integration.


## Building

1. Clone the project.
2. Open the project file in Xcode.
3. Select the ```OoyalaSSAISampleApp``` scheme
4. Build the project.


## Project Structure

An [AssetListViewController](./OoyalaSSAISampleApp/Views/AssetListViewController.swift) shows a list of available videos along with [metadata](./OoyalaSSAISampleApp/Models/PlayerSelectionOption.swift) about these videos. When a video is selected, it opens in a [PlayerViewController](./OoyalaSSAISampleApp/Views/PlayerViewController.swift).

The PlayerViewController creates an OOOoyalaPlayer and then associates it with an instance of the OOSsaiPlugin class from the OoyalaSSAISDK framework. OOSsaiPlugin will allow ads to be shown for video content that is associated to the asset.

```
let ssaiPlugin: OOSsaiPlugin
ssaiPlugin = OOSsaiPlugin(); // Without player params
ssaiPlugin = OOSsaiPlugin(params: ssaiParams); // With player params
```

The OOOoyalaPlayer object needs to be registered to the plugin, so the plugin can start make impressions and shows the ad mode when an ad is coming. The OOOoyalaPlayer object can be deregistered to stop make impressions.

```
ssaiPlugin.register(player);
ssaiPlugin.deregister(player);
```

The plugin can override the ad parameters for retrieve the ad set, the object is a valid json string depending the ad provider.

```
ssaiPlugin.setParams(params);
```

**Ooyala Pulse**
```
{
	"videoplaza-ads-manager": {
		"metadata": {
			"all_ads": [{
				"position": "7"
			}],
			"playerLevelShares": "catfromquerystring",
			"playerLevelTags": "tagsfromquerystring",
			"playerLevelCuePoints": "30,10,20",
			"vpDomain": "domainfromquerystring"
		}
	}
}
```

| Query String Parameters for Ooyala Pulse | Ooyala SSAI Parameters |
| -----------------------------------------| ---------------------- |
| pulse_host                               | vpDomain               |
| pulse_category                           | playerLevelShares      |
| pulse_tags                               | playerLevelTags        |
| pulse_linear_cuepoints                   | playerLevelCuePoints   |
|                                          | position *             |

* position is a bit field:Bit 0=Pre-roll, bit 1=mid-roll, bit 2=post-roll

**DFP**
```
{
	"google-ima-ads-manager": {
		"metadata": {
			"all_ads": [{
				"position": "70000",
				"tag_url": "https://pubads.g.doubleclick.net/gampad/ads?correlator=[timestamp]&env=vp&gdfp_req=1&output=xml_vast3&sz=1280x720&unviewed_position_start=1&ad_rule=0&pmnd=0&pmxd=90000&pmad=15&d_impl=1&d_imp_hdr=1&iu=/7521029/live_test_unit&url=[referrer_url]&cust_params=live_test_unit%3Dme",
				"position_type": "t"
			}, {
				"position": "20000",
				"tag_url": "https://pubads.g.doubleclick.net/gampad/ads?correlator=[timestamp]&env=vp&gdfp_req=1&output=xml_vast3&sz=1280x720&unviewed_position_start=1&ad_rule=0&pmnd=0&pmxd=90000&pmad=15&d_impl=1&d_imp_hdr=1&iu=/7521029/live_test_unit&url=[referrer_url]&cust_params=live_test_unit%3Dfe",
				"position_type": "t"
			}, {
				"position": "10000",
				"tag_url": "https://pubads.g.doubleclick.net/gampad/ads?correlator=[timestamp]&env=vp&gdfp_req=1&output=xml_vast3&sz=1280x720&unviewed_position_start=1&ad_rule=0&pmnd=0&pmxd=90000&pmad=15&d_impl=1&d_imp_hdr=1&iu=/7521029/live_test_unit&url=[referrer_url]&cust_params=live_test_unit%3Dfw",
				"position_type": "t"
			}, {
				"position": "90000",
				"tag_url": "https://pubads.g.doubleclick.net/gampad/ads?correlator=[timestamp]&env=vp&gdfp_req=1&output=xml_vast3&sz=1280x720&unviewed_position_start=1&ad_rule=0&pmnd=0&pmxd=90000&pmad=15&d_impl=1&d_imp_hdr=1&iu=/7521029/live_test_unit&url=[referrer_url]&cust_params=live_test_unit%3Dmw",
				"position_type": "t"
			}]
		}
	}
}
```

| Query String Parameters for Google IMA | Ooyala SSAI Parameters |
| ---------------------------------------| ---------------------- |
| position                               | position               |
| tag_url                                | tag_url                |
| position_type                          | position_type *        |

* For SSAI, only position_type **‘t’** is supported.


## Useful information

- [Ooyala Pulse Ad Parameters Reference](https://help.ooyala.com/video-platform/concepts/pbv4_ads_dev_pulse_parameters.html)
- [Google IMA Ad Parameters Reference](https://help.ooyala.com/video-platform/concepts/pbv4_ads_dev_google_ima_parameters.html)
