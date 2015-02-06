/**
 * @file       OOConstants.h
 * @brief      OOConstants
 * @details    OOConstants.h in OoyalaSDK
 * @date       11/23/11
 * @copyright Copyright (c) 2015 Ooyala, Inc. All rights reserved.
 */

extern void OOOoyalaPlayerSetEnvironment(NSInteger e);

extern NSString *const OO_SDK_VERSION;                        /**< Ooyala iOS SDK Version */
extern NSString *const OO_API_VERSION;                        /**< Player API Version that this SDK uses */

extern NSString *OO_JS_ANALYTICS_HOST;                        /**< The standalone js analytics host */
extern NSString *OO_AUTHORIZE_HOST;                           /**< The SAS authorize host */
extern NSString *OO_CONTENT_TREE_HOST;                        /**< The content tree host */
extern NSString *OO_METADATA_HOST;                            /**< The metadata host */
extern NSString *OO_BACKLOT_HOST;                             /**< The Backlot API v2 host */

extern NSString *const OO_JS_ANALYTICS_URI;                   /**< The standalone js analytics URI path */
extern NSString *const OO_JS_ANALYTICS_USER_AGENT_PREFIX;     /**< The useragent prefix for analytics requests */
extern NSString *const OO_JS_ANALYTICS_USER_AGENT_FORMAT;     /**< The useragent used for analytics requests (for use with stringWithFormat:) */
extern NSString *const OO_JS_ANALYTICS_ACCOUNT_ID;            /**< The account ID variable in JS Analytics */
extern NSString *const OO_JS_ANALYTICS_GUID;                  /**< The GUID variable in JS Analytics */

extern NSString *const OO_API_CONTENT_TREE;                   /**< The string name of the content tree API */
extern NSString *const OO_API_CONTENT_TREE_NEXT;              /**< The string name of the content tree next API */
extern NSString *const OO_API_AUTHORIZE;                      /**< The string name of the authorize API */
extern NSString *const OO_API_METADATA;                       /**< The string name of the metadata API */

extern NSString *const OO_AUTHORIZE_CONTENT_ID_URI;           /**< The SAS authorize by content id API URI */
extern NSString *const OO_AUTHORIZE_EMBED_CODE_URI;           /**< The SAS authorize by embed code API URI */
extern NSString *const OO_AUTHORIZE_HEARTBEAT_URI;            /**< The SAS heartbeat */
extern NSString *const OO_AUTHORIZE_PUBLIC_KEY_B64;           /**< The base64 encoded public key for SAS authorize */
extern NSString *const OO_AUTHORIZE_PUBLIC_KEY_NAME;          /**< The name for the public key in the internal iOS keychain */
extern NSUInteger const OO_AUTHORIZE_SIGNATURE_DIGEST_LENGTH; /**< The max length of the SHA256 digest that the SAS authorize API uses to generate the signature */
extern NSInteger const OO_AUTHORIZE_RESPONSE_LIFE_SECONDS;    /**< The SAS authorize response lifetime in seconds */

extern NSString *const OO_CONTENT_TREE_URI;                   /**< The content tree API URI */
extern NSString *const OO_CONTENT_TREE_BY_EXTERNAL_ID_URI;    /**< The content tree by External ID API URI */
extern NSString *const OO_CONTENT_TREE_NEXT_URI;              /**< The content tree next API URI */

extern NSString *const OO_METADATA_EMBED_CODE_URI;            /**< The metadata by embed code API URI */

extern NSString *const OO_BACKLOT_URI;                        /**< The Backlot API v2 URI */

extern NSString *const OO_KEY_EMBED_CODE;                     /**< The JSON dictionary key for embed_code */
extern NSString *const OO_KEY_EXTERNAL_ID;                    /**< The JSON dictionary key for external_id */
extern NSString *const OO_KEY_API_KEY;                        /**< The JSON dictionary key for api_key */
extern NSString *const OO_KEY_DOMAIN;                         /**< The JSON dictionary key for domain */
extern NSString *const OO_KEY_EXPIRES;                        /**< The JSON dictionary key for expires */
extern NSString *const OO_KEY_SIGNATURE;                      /**< The JSON dictionary key for signature */
extern NSString *const OO_KEY_DEVICE;                         /**< The JSON dictionary key for device */
extern NSString *const OO_KEY_ERRORS;                         /**< The JSON dictionary key for errors */
extern NSString *const OO_KEY_CODE;                           /**< The JSON dictionary key for code */
extern NSString *const OO_KEY_AUTHORIZATION_DATA;             /**< The JSON dictionary key for authorization_data */
extern NSString *const OO_KEY_AUTH_TOKEN;                     /**< The JSON dictionary key for auth_token */
extern NSString *const OO_KEY_HEARTBEAT_DATA;                 /**< The JSON dictionary key for hearbeat_data */
extern NSString *const OO_KEY_HEARTBEAT_INTERVAL;             /**< The JSON dictionary key for heartbeat_interval */
extern NSString *const OO_KEY_ACCOUNT_ID;                     /**< The JSON dictionary key for account_id */
extern NSString *const OO_KEY_AUTHORIZED;                     /**< The JSON dictionary key for authorized */
extern NSString *const OO_KEY_CONTENT_TREE;                   /**< The JSON dictionary key for content_tree */
extern NSString *const OO_KEY_CONTENT_TOKEN;                  /**< The JSON dictionary key for content_token */
extern NSString *const OO_KEY_TITLE;                          /**< The JSON dictionary key for title */
extern NSString *const OO_KEY_DESCRIPTION;                    /**< The JSON dictionary key for description */
extern NSString *const OO_KEY_PROMO_IMAGE;                    /**< The JSON dictionary key for promo image */
extern NSString *const OO_KEY_REQUIRE_HEARTBEAT;              /**< The JSON dictionary key for heartbeat */
extern NSString *const OO_KEY_THUMBNAIL_IMAGE;                /**< The JSON dictionary key for thumbnail image */
extern NSString *const OO_KEY_CONTENT_TYPE;                   /**< The JSON dictionary key for content_type */
extern NSString *const OO_KEY_CHILDREN;                       /**< The JSON dictionary key for children */
extern NSString *const OO_KEY_VIDEO_BITRATE;                  /**< The JSON dictionary key for video_bitrate */
extern NSString *const OO_KEY_AUDIO_BITRATE;                  /**< The JSON dictionary key for audio_bitrate */
extern NSString *const OO_KEY_VIDEO_CODEC;                    /**< The JSON dictionary key for video_codec */
extern NSString *const OO_KEY_HEIGHT;                         /**< The JSON dictionary key for height */
extern NSString *const OO_KEY_WIDTH;                          /**< The JSON dictionary key for width */
extern NSString *const OO_KEY_FRAMERATE;                      /**< The JSON dictionary key for framerate */
extern NSString *const OO_KEY_DELIVERY_TYPE;                  /**< The JSON dictionary key for delivery_type */
extern NSString *const OO_KEY_URL;                            /**< The JSON dictionary key for url */
extern NSString *const OO_KEY_DATA;                           /**< The JSON dictionary key for data */
extern NSString *const OO_KEY_FORMAT;                         /**< The JSON dictionary key for format */
extern NSString *const OO_KEY_STREAMS;                        /**< The JSON dictionary key for streams */
extern NSString *const OO_KEY_MESSAGE;                        /**< The JSON dictionary key for message */
extern NSString *const OO_KEY_ADS;                            /**< The JSON dictionary key for ads */
extern NSString *const OO_KEY_TYPE;                           /**< The JSON dictionary key for type */
extern NSString *const OO_KEY_AD_EMBED_CODE;                  /**< The JSON dictionary key for ad_embed_code */
extern NSString *const OO_KEY_AD_SET_CODE;                    /**< The JSON dictionary key for adSetCode */
extern NSString *const OO_KEY_TIME;                           /**< The JSON dictionary key for time */
extern NSString *const OO_KEY_CLICK_URL;                      /**< The JSON dictionary key for click_url */
extern NSString *const OO_KEY_TRACKING_URL;                   /**< The JSON dictionary key for tracking_url */
extern NSString *const OO_KEY_IS_LIVE_STREAM;                 /**< The JSON dictionary key for is_live_stream */
extern NSString *const OO_KEY_ASPECT_RATIO;                   /**< The JSON dictionary key for aspect_ratio */
extern NSString *const OO_KEY_NEXT_CHILDREN;                  /**< The JSON dictionary key for next_children */
extern NSString *const OO_KEY_DURATION;                       /**< The JSON dictionary key for duration */
extern NSString *const OO_KEY_CLOSED_CAPTIONS;                /**< The JSON dictionary key for closed_captions */
extern NSString *const OO_KEY_LANGUAGES;                      /**< The JSON dictionary key for languages */
extern NSString *const OO_KEY_DEFAULT_LANGUAGE;               /**< The JSON dictionary key for default_language */
extern NSString *const OO_KEY_NEXT_TOKEN;                     /**< The dictionary key for next_token */
extern NSString *const OO_KEY_PARENT;                         /**< The dictionary key for parent */
extern NSString *const OO_KEY_API;                            /**< The dictionary key for api */
extern NSString *const OO_KEY_CALLBACK;                       /**< The dictionary key for callback */
extern NSString *const OO_KEY_PROFILE;                        /**< The JSON dictionary key for profile */
extern NSString *const OO_KEY_DEBUG_DATA;                     /**< The JSON dictionary key for debug data */
extern NSString *const OO_KEY_USER_INFO;                      /**< The JSON dictionary key for user info */
extern NSString *const OO_KEY_TIMESTAMP;                      /**< The JSON dictionary key for timestamp */
extern NSString *const OO_KEY_SERVER_LATENCY;                 /**< The JSON dictionary key for server latency */
extern NSString *const OO_KEY_WIDEVINE_SERVER_PATH;           /**< The JSON dictionary key for widevine server path */
extern NSString *const OO_KEY_METADATA;                       /**< The JSON dictionary key for metadata */
extern NSString *const OO_KEY_METADATA_BASE;                  /**< The JSON dictionary key for base metadata */
extern NSString *const OO_KEY_METADATA_MODULES;               /**< The JSON dictionary key for module metadata */
extern NSString *const OO_KEY_METADATA_MODULE_TYPE;           /**< The JSON dictionary key for module type */
extern NSString *const OO_KEY_METADATA_TVRATING_RATING;       /**< The JSON dictionary key for tv rating age restriction. */
extern NSString *const OO_KEY_METDATA_TVRATING_SUBRATING;     /**< The JSON dictionary key for tv rating labels. */
extern NSString *const OO_KEY_METADATA_TVRATING_CLICKTHROUGH_URL; /**< The JSON dictionary key for tv rating clickthrough url. */

extern NSString *const OO_KEY_USER_ACCOUNT_ID;                /**< The JSON dictionary key for a user's account_id */
extern NSString *const OO_KEY_USER_CONTINENT;                 /**< The JSON dictionary key for a user's continent */
extern NSString *const OO_KEY_USER_COUNTRY;                   /**< The JSON dictionary key for a user's country */
extern NSString *const OO_KEY_USER_DEVICE;                    /**< The JSON dictionary key for a user's device */
extern NSString *const OO_KEY_USER_DOMAIN;                    /**< The JSON dictionary key for a user's domain */
extern NSString *const OO_KEY_USER_IPADDRESS;                 /**< The JSON dictionary key for a user's ip address */
extern NSString *const OO_KEY_USER_LANGUAGE;                  /**< The JSON dictionary key for language */
extern NSString *const OO_KEY_USER_TIMEZONE;                  /**< The JSON dictionary key for timezone */

extern NSString *const OO_DEVICE_IOS;                         /**< The device parameter value for any iOS device (see PBK-459) */

extern NSString *const OO_CONTENT_TYPE_CHANNEL_SET;           /**< The content_type value for ChannelSet */
extern NSString *const OO_CONTENT_TYPE_CHANNEL;               /**< The content_type value for Channel */
extern NSString *const OO_CONTENT_TYPE_VIDEO;                 /**< The content_type value for Video */
extern NSString *const OO_CONTENT_TYPE_LIVE_STREAM;           /**< The content_type value for LiveStream */

extern NSString *const OO_STREAM_URL_FORMAT_TEXT;             /**< The stream url format value for text */
extern NSString *const OO_STREAM_URL_FORMAT_B64;              /**< The stream url format value for base 64 encoded */

extern NSString *const OO_AD_TYPEOOYALA;                     /**< The ad type value for Ooyala ads */
extern NSString *const OO_AD_TYPEVAST;                       /**< The ad type value for VAST ads */

extern NSString *const OO_METHOD_GET;                         /**< The HTTP Request Method GET */
extern NSString *const OO_METHOD_PUT;                         /**< The HTTP Request Method PUT */
extern NSString *const OO_METHOD_POST;                        /**< The HTTP Request Method POST */

extern NSString *const OO_SEPARATOR_AMPERSAND;                /**< Ampersand "&" */
extern NSString *const OO_SEPARATOR_COMMA;                    /**< Comma "," */
extern NSString *const OO_SEPARATOR_EMPTY;                    /**< Empty String "" */
extern NSString *const OO_SEPARATOR_NEWLINE;                  /**< Newline character "\n" */
extern NSString *const OO_SEPARATOR_COLON;                    /**< Colon ":" */

extern NSString *const OO_DELIVERY_TYPE_HLS;                  /**< The delivery_type value for hls */
extern NSString *const OO_DELIVERY_TYPE_MP4;                  /**< The delivery_type value for mp4 */
extern NSString *const OO_DELIVERY_TYPE_REMOTE_ASSET;         /**< The delivery_type calue for remote assets */
extern NSString *const OO_DELIVERY_TYPE_WV_WVM;               /**< The delivery_type value for widevine encrypted content */
extern NSString *const OO_DELIVERY_TYPE_WV_HLS;               /**< The delivery_type value for widevine encrypted content */
extern NSString *const OO_DELIVERY_TYPE_SMOOTH;               /**< The delivery_type value for PlayReady Smooth encrypted content */

extern NSInteger const OO_DEFAULT_AD_TIME_SECONDS;            /**< The default time (in seconds) an Ad should run at if not specified */

// VAST related stuff
extern float const OO_MINIMUM_SUPPORTED_VAST_VERSION;         /**< The minimum supported VAST version */
extern char *const OO_ELEMENT_VAST;                           /**< The XML element name for VAST */
extern char *const OO_ELEMENT_AD;                             /**< The XML element name for Ad */
extern char *const OO_ELEMENT_IN_LINE;                        /**< The XML element name for InLine */
extern char *const OO_ELEMENT_WRAPPER;                        /**< The XML element name for Wrapper */
extern char *const OO_ELEMENT_AD_SYSTEM;                      /**< The XML element name for AdSystem */
extern char *const OO_ELEMENT_AD_TITLE;                       /**< The XML element name for AdTitle */
extern char *const OO_ELEMENT_DESCRIPTION;                    /**< The XML element name for Description */
extern char *const OO_ELEMENT_SURVEY;                         /**< The XML element name for Survey */
extern char *const OO_ELEMENT_ERROR;                          /**< The XML element name for Error */
extern char *const OO_ELEMENT_IMPRESSION;                     /**< The XML element name for Impression */
extern char *const OO_ELEMENT_CREATIVES;                      /**< The XML element name for Creatives */
extern char *const OO_ELEMENT_CREATIVE;                       /**< The XML element name for Creative */
extern char *const OO_ELEMENT_LINEAR;                         /**< The XML element name for Linear */
extern char *const OO_ELEMENT_NON_LINEAR_ADS;                 /**< The XML element name for NonLinearAds */
extern char *const OO_ELEMENT_COMPANION_ADS;                  /**< The XML element name for CompanionAds */
extern char *const OO_ELEMENT_EXTENSIONS;                     /**< The XML element name for Extensions */
extern char *const OO_ELEMENT_DURATION;                       /**< The XML element name for Duration */
extern char *const OO_ELEMENT_TRACKING_EVENTS;                /**< The XML element name for TrackingEvents */
extern char *const OO_ELEMENT_TRACKING;                       /**< The XML element name for Tracking */
extern char *const OO_ELEMENT_AD_PARAMETERS;                  /**< The XML element name for AdParameters */
extern char *const OO_ELEMENT_VIDEO_CLICKS;                   /**< The XML element name for VideoClicks */
extern char *const OO_ELEMENT_CLICK_THROUGH;                  /**< The XML element name for ClickThrough */
extern char *const OO_ELEMENT_CLICK_TRACKING;                 /**< The XML element name for ClickTracking */
extern char *const OO_ELEMENT_CUSTOM_CLICK;                   /**< The XML element name for CustomClick */
extern char *const OO_ELEMENT_MEDIA_FILES;                    /**< The XML element name for MediaFiles */
extern char *const OO_ELEMENT_MEDIA_FILE;                     /**< The XML element name for MediaFile */
extern char *const OO_ELEMENT_VAST_AD_TAG_URI;                /**< The XML element name for VASTAdTagURI */
extern char *const OO_ELEMENT_TT;                             /**< The XML element name for tt */
extern char *const OO_ELEMENT_HEAD;                           /**< The XML element name for head */
extern char *const OO_ELEMENT_BODY;                           /**< The XML element name for body */
extern char *const OO_ELEMENT_STYLING;                        /**< The XML element name for styling */
extern char *const OO_ELEMENT_STYLE;                          /**< The XML element name for style */
extern char *const OO_ELEMENT_DIV;                            /**< The XML element name for div */
extern char *const OO_ELEMENT_P;                              /**< The XML element name for p */
extern char *const OO_ELEMENT_SPAN;                           /**< The XML element name for span */
extern char *const OO_ELEMENT_BR;                             /**< The XML element name for br */
extern NSString *const OO_ATTRIBUTE_VERSION;                  /**< The XML attribute name for version */
extern NSString *const OO_ATTRIBUTE_ID;                       /**< The XML attribute name for id */
extern NSString *const OO_ATTRIBUTE_SEQUENCE;                 /**< The XML attribute name for sequence */
extern NSString *const OO_ATTRIBUTE_EVENT;                    /**< The XML attribute name for event */
extern NSString *const OO_ATTRIBUTE_DELIVERY;                 /**< The XML attribute name for delivery */
extern NSString *const OO_ATTRIBUTE_TYPE;                     /**< The XML attribute name for type */
extern NSString *const OO_ATTRIBUTE_BITRATE;                  /**< The XML attribute name for bitrate */
extern NSString *const OO_ATTRIBUTE_WIDTH;                    /**< The XML attribute name for width */
extern NSString *const OO_ATTRIBUTE_HEIGHT;                   /**< The XML attribute name for height */
extern NSString *const OO_ATTRIBUTE_SCALABLE;                 /**< The XML attribute name for scalable */
extern NSString *const OO_ATTRIBUTE_MAINTAIN_ASPECT_RATIO;    /**< The XML attribute name for maintainAspectRatio */
extern NSString *const OO_ATTRIBUTE_API_FRAMEWORK;            /**< The XML attribute name for apiFramework */
extern NSString *const OO_ATTRIBUTE_BEGIN;                    /**< The XML attribute name for begin */
extern NSString *const OO_ATTRIBUTE_END;                      /**< The XML attribute name for end */
extern NSString *const OO_ATTRIBUTE_DUR;                      /**< The XML attribute name for dur */
extern NSString *const OO_ATTRIBUTE_XML_LANG;                 /**< The XML attribute name for xml:lang */

extern NSString *const OO_MIME_TYPE_MP4;                      /**< The MIME type for .mp4 files */
extern NSString *const OO_MIME_TYPE_M3U8;                     /**< The MIME type for .m3u8 files */
