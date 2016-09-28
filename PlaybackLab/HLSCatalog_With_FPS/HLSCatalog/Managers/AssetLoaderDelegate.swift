/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 `AssetLoaderDelegate` is a class that implements an AVAssetResourceLoader delegate that will handle FairPlay Streaming key requests.
 */

import Foundation
import AVFoundation

public class AssetLoaderDelegate: NSObject {
  
  let pcode = "x0b2cyOupu0FFK5hCr4zXg8KKcrm"
  let apiKey = "x0b2cyOupu0FFK5hCr4zXg8KKcrm.-s6jH"
  let apiSecret = "ZCMQt2CCVqlHWce6dG5w2WA6fkAM_JaWgoI_yzQp"
  
  let secureUrlGenerator: OOSecureURLGenerator
  
  let timeout :TimeInterval = 60.0
  
  
    /// The URL scheme for FPS content.
    static let customScheme = "skd"
    
    /// Error domain for errors being thrown in the process of getting a CKC.
    static let errorDomain = "HLSCatalogErrorDomain"
    
    /// Notification for when the persistent content key has been saved to disk.
    static let didPersistContentKeyNotification = NSNotification.Name(rawValue: "handleAssetLoaderDelegateDidPersistContentKeyNotification")
    
    /// The AVURLAsset associated with the asset.
    let asset: AVURLAsset
    
    /// The name associated with the asset.
    let assetName: String
    
    /// The DispatchQueue to use for AVAssetResourceLoaderDelegate callbacks.
    let resourceLoadingRequestQueue = DispatchQueue(label: "com.example.apple-samplecode.resourcerequests")
    
    /// The document URL to use for saving persistent content key.
    let documentURL: URL
  
    init(asset: AVURLAsset, assetName: String) {
        // Determine the library URL.
        guard let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { fatalError("Unable to determine library URL") }
        documentURL = URL(fileURLWithPath: documentPath)
        
        self.asset = asset
        self.assetName = assetName
      self.secureUrlGenerator = OOEmbeddedSecureURLGenerator(apiKey: self.apiKey, secret: self.apiSecret)
        
        super.init()
        
        self.asset.resourceLoader.setDelegate(self, queue: DispatchQueue(label: "\(assetName)-delegateQueue"))
    }
    
    
    /// Returns the Application Certificate needed to generate the Server Playback Context message.
    public func fetchApplicationCertificate() -> Data? {
        
        // MARK: ADAPT: YOU MUST IMPLEMENT THIS METHOD.
      var applicationCertificate: Data? = nil
      let expires = round(NSDate().timeIntervalSince1970 + self.timeout)
      var params = [String: String]()
      params["expires"] = String(format: "%ld", expires)
      
      let uri = String(format: "/sas/fps/%@/certificate", self.pcode)
      let signedUrl = self.secureUrlGenerator .secureURL("http://10.11.66.52:4567", uri: uri, params: params)
      guard let jsonBytes = OONetUtils.request(signedUrl, timeout: self.timeout) else {
        return applicationCertificate
      }
      
      let d = OOUtils.object(fromJSONData: jsonBytes) as! NSDictionary
      let error = d["error"] as? String
      
      if (error != nil) {
        return applicationCertificate
      }
      
      let b64 = d["certificate"] as! String
      applicationCertificate = OOUtils.decodeUrlSafeBase64(with: b64)
      
      if applicationCertificate == nil {
          fatalError("No certificate being returned by \(#function)!")
      }
      
      return applicationCertificate
    }
    
    public func contentKeyFromKeyServerModuleWithSPCData(spcData: Data, assetIDString: String) -> Data? {
        
        // MARK: ADAPT: YOU MUST IMPLEMENT THIS METHOD.
      var ckcData: Data? = nil
    
      var params = [String: String]()
      params["asset_id"] = assetIDString
      params["spc"] = OOUtils.encodeBase64(with: spcData)
      let uri = String(format: "%@%@", "http://10.11.66.52:4567", String(format: "/sas/fps/%@/key/offline", self.pcode))
      var response: HTTPURLResponse? = nil
      guard let jsonBytes = OONetUtils.postSynchronous(URL(string: uri),
                                                 timeout: self.timeout,
                                                 data: params,
                                                 response: &response) else {
                                                  return ckcData
      }
      
      if (nil != response && ((response?.statusCode)! < 200 || (response?.statusCode)! > 299)) {
        return ckcData
      }
      
      let d = OOUtils.object(fromJSONData: jsonBytes) as! NSDictionary
      let b64 = d["ckc"] as! String
      ckcData = OOUtils.decodeUrlSafeBase64(with: b64)
      
      if ckcData == nil {
          fatalError("No CKC being returned by \(#function)!")
      }
      
      
      return ckcData
    }
    
    public func deletePersistedConentKeyForAsset() {
        guard let filePathURLForPersistedContentKey = filePathURLForPersistedContentKey() else {
            return
        }
        
        do {
            try FileManager.default.removeItem(at: filePathURLForPersistedContentKey)
            
            UserDefaults.standard.removeObject(forKey: "\(assetName)-Key")
        } catch {
            print("An error occured removing the persisted content key: \(error)")
        }
    }
    
}

//MARK:- Internal methods extension.
private extension AssetLoaderDelegate {
    func filePathURLForPersistedContentKey() -> URL? {
        var filePathURL: URL?
        
        guard let fileName = UserDefaults.standard.value(forKey: "\(assetName)-Key") as? String else {
            return filePathURL
        }
        
        do {
            let url = try documentURL.appendingPathComponent(fileName)
            filePathURL = url
        } catch {
            return filePathURL
        }
        
        return filePathURL
    }
    
    func prepareAndSendContentKeyRequest(resourceLoadingRequest: AVAssetResourceLoadingRequest) {
        
        guard let url = resourceLoadingRequest.request.url, let assetIDString = url.host else {
            print("Failed to get url or assetIDString for the request object of the resource.")
            return
        }
        
        let shouldPersist = asset.resourceLoader.preloadsEligibleContentKeys
        
        // Check if this reuqest is the result of a potential AVAssetDownloadTask.
        if shouldPersist {
            if resourceLoadingRequest.contentInformationRequest != nil {
                resourceLoadingRequest.contentInformationRequest!.contentType = AVStreamingKeyDeliveryPersistentContentKeyType
            }
            else {
                print("Unable to set contentType on contentInformationRequest.")
                let error = NSError(domain: AssetLoaderDelegate.errorDomain, code: -1, userInfo: nil)
                resourceLoadingRequest.finishLoading(with: error)
                return
            }
        }
      
        // Check if we have an existing key on disk for this asset.
        if let filePathURLForPersistedContentKey = filePathURLForPersistedContentKey() {
            
            // Verify the file does actually exist on disk.
            if FileManager.default.fileExists(atPath: filePathURLForPersistedContentKey.path) {
                
                do {
                    // Load the contents of the persistedContentKey file.
                    let persistedContentKeyData = try Data(contentsOf: filePathURLForPersistedContentKey)
                    
                    guard let dataRequest = resourceLoadingRequest.dataRequest else {
                        print("Error loading contents of content key file.")
                        let error = NSError(domain: AssetLoaderDelegate.errorDomain, code: -2, userInfo: nil)
                        resourceLoadingRequest.finishLoading(with: error)
                        return
                    }
                    
                    // Pass the persistedContentKeyData into the dataRequest so complete the content key request.
                    dataRequest.respond(with: persistedContentKeyData)
                    resourceLoadingRequest.finishLoading()
                    return
                    
                } catch let error as NSError {
                    print("Error initializing Data from contents of URL: \(error.localizedDescription)")
                    resourceLoadingRequest.finishLoading(with: error)
                    return
                }
            }
        }
        
        // Get the application certificate.
        guard let applicationCertificate = fetchApplicationCertificate() else {
            print("Error loading application certificate.")
            let error = NSError(domain: AssetLoaderDelegate.errorDomain, code: -3, userInfo: nil)
            resourceLoadingRequest.finishLoading(with: error)
            return
        }
      
        guard let assetIDData = assetIDString.data(using: String.Encoding.utf8) else {
            print("Error retrieving Asset ID.")
            let error = NSError(domain: AssetLoaderDelegate.errorDomain, code: -4, userInfo: nil)
            resourceLoadingRequest.finishLoading(with: error)
            return
        }
        
        var resourceLoadingRequestOptions: [String : AnyObject]? = nil
        
        // Check if this reuqest is the result of a potential AVAssetDownloadTask.
        if shouldPersist {
            // Since this request is the result of an AVAssetDownloadTask, we configure the options to request a persistent content key from the KSM.
            resourceLoadingRequestOptions = [AVAssetResourceLoadingRequestStreamingContentKeyRequestRequiresPersistentKey: true as AnyObject]
        }
        
        let spcData: Data!
        
        do {
            /* 
             To obtain the Server Playback Context (SPC), we call 
             AVAssetResourceLoadingRequest.streamingContentKeyRequestData(forApp:contentIdentifier:options:)
             using the information we obtained earlier.
             */
            spcData = try resourceLoadingRequest.streamingContentKeyRequestData(forApp: applicationCertificate, contentIdentifier: assetIDData, options: resourceLoadingRequestOptions)
        } catch let error as NSError {
            print("Error obtaining key request data: \(error.domain) reason: \(error.localizedFailureReason)")
            resourceLoadingRequest.finishLoading(with: error)
            return
        }
        
        /*
         Send the SPC message (requestBytes) to the Key Server and get a CKC in reply.
         
         The Key Server returns the CK inside an encrypted Content Key Context (CKC) message in response to
         the app’s SPC message.  This CKC message, containing the CK, was constructed from the SPC by a
         Key Security Module in the Key Server’s software.
         
         When a KSM receives an SPC with a media playback state TLLV, the SPC may include a content key duration TLLV
         in the CKC message that it returns. If the Apple device finds this type of TLLV in a CKC that delivers an FPS
         content key, it will honor the type of rental or lease specified when the key is used.
         */
        guard let ckcData = contentKeyFromKeyServerModuleWithSPCData(spcData: spcData, assetIDString: assetIDString) else {
            print("Error retrieving CKC from KSM.")
            let error = NSError(domain: AssetLoaderDelegate.errorDomain, code: -5, userInfo: nil)
            resourceLoadingRequest.finishLoading(with: error)
            return
        }
        
        // Check if this reuqest is the result of a potential AVAssetDownloadTask.
        if shouldPersist {
            // Since this request is the result of an AVAssetDownloadTask, we should get the secure persistent content key.
            var error: NSError?
            
            /*
             Obtain a persistable content key from a context.
             
             The data returned from this method may be used to immediately satisfy an
             AVAssetResourceLoadingDataRequest, as well as any subsequent requests for the same key url.
             
             The value of AVAssetResourceLoadingContentInformationRequest.contentType must be set to AVStreamingKeyDeliveryPersistentContentKeyType when responding with data created with this method.
             */
            let persistentContentKeyData = resourceLoadingRequest.persistentContentKey(fromKeyVendorResponse: ckcData, options: nil, error: &error)
            
            if let error = error {
                print("Error creating persistent content key: \(error)")
                resourceLoadingRequest.finishLoading(with: error)
                return
            }
            
            // Save the persistentContentKeyData onto disk for use in the future.
            do {
                let persistentContentKeyURL = try documentURL.appendingPathComponent("\(asset.url.hashValue).key")
                
                do {
                    try persistentContentKeyData.write(to: persistentContentKeyURL, options: Data.WritingOptions.atomicWrite)
                    
                    // Since the save was successful, store the location of the key somewhere to reuse it for future calls.
                    UserDefaults.standard.set("\(asset.url.hashValue).key", forKey: "\(assetName)-Key")
                    
                    guard let dataRequest = resourceLoadingRequest.dataRequest else {
                        print("no data is being requested in loadingRequest")
                        let error = NSError(domain: AssetLoaderDelegate.errorDomain, code: -6, userInfo: nil)
                        resourceLoadingRequest.finishLoading(with: error)
                        return
                    }
                    
                    // Provide data to the loading request.
                    dataRequest.respond(with: persistentContentKeyData)
                    resourceLoadingRequest.finishLoading()  // Treat the processing of the request as complete.
                    
                    // Since the request has complete, notify the rest of the app that the content key has been persisted for this asset.
                    
                    NotificationCenter.default.post(name: AssetLoaderDelegate.didPersistContentKeyNotification, object: asset, userInfo: [Asset.Keys.name : assetName])
                    
                } catch let error as NSError {
                    print("failed writing persisting key to path: \(persistentContentKeyURL) with error: \(error)")
                    resourceLoadingRequest.finishLoading(with: error)
                    return
                }
                
            } catch let error as NSError {
                print("failed to create the URL for writing the persistent content key: \(error.localizedDescription)")
                resourceLoadingRequest.finishLoading(with: error)
                return
            }
        }
        else {
            guard let dataRequest = resourceLoadingRequest.dataRequest else {
                print("no data is being requested in loadingRequest")
                let error = NSError(domain: AssetLoaderDelegate.errorDomain, code: -6, userInfo: nil)
                resourceLoadingRequest.finishLoading(with: error)
                return
            }
            
            // Provide data to the loading request.
            dataRequest.respond(with: ckcData)
            resourceLoadingRequest.finishLoading()  // Treat the processing of the request as complete.
        }
    }
    
    
    func shouldLoadOrRenewRequestedResource(resourceLoadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        
        guard let url = resourceLoadingRequest.request.url else {
            return false
        }
        
        // AssetLoaderDelegate only should handle FPS Content Key requests.
        if url.scheme != AssetLoaderDelegate.customScheme {
            return false
        }
        
        resourceLoadingRequestQueue.async {
            self.prepareAndSendContentKeyRequest(resourceLoadingRequest: resourceLoadingRequest)
        }
        
        return true
    }
}

//MARK:- AVAssetResourceLoaderDelegate protocol methods extension
extension AssetLoaderDelegate: AVAssetResourceLoaderDelegate {
    
    /*
     resourceLoader:shouldWaitForLoadingOfRequestedResource:
     
     When iOS asks the app to provide a CK, the app invokes
     the AVAssetResourceLoader delegate’s implementation of
     its -resourceLoader:shouldWaitForLoadingOfRequestedResource:
     method. This method provides the delegate with an instance
     of AVAssetResourceLoadingRequest, which accesses the
     underlying NSURLRequest for the requested resource together
     with support for responding to the request.
     */
    public func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForLoadingOfRequestedResource loadingRequest: AVAssetResourceLoadingRequest) -> Bool {
        
        print("\(#function) was called in AssetLoaderDelegate with loadingRequest: \(loadingRequest)")
        
        return shouldLoadOrRenewRequestedResource(resourceLoadingRequest: loadingRequest)
    }
    
    
    /*
     resourceLoader: shouldWaitForRenewalOfRequestedResource:
     
     Delegates receive this message when assistance is required of the application
     to renew a resource previously loaded by
     resourceLoader:shouldWaitForLoadingOfRequestedResource:. For example, this
     method is invoked to renew decryption keys that require renewal, as indicated
     in a response to a prior invocation of
     resourceLoader:shouldWaitForLoadingOfRequestedResource:. If the result is
     YES, the resource loader expects invocation, either subsequently or
     immediately, of either -[AVAssetResourceRenewalRequest finishLoading] or
     -[AVAssetResourceRenewalRequest finishLoadingWithError:]. If you intend to
     finish loading the resource after your handling of this message returns, you
     must retain the instance of AVAssetResourceRenewalRequest until after loading
     is finished. If the result is NO, the resource loader treats the loading of
     the resource as having failed. Note that if the delegate's implementation of
     -resourceLoader:shouldWaitForRenewalOfRequestedResource: returns YES without
     finishing the loading request immediately, it may be invoked again with
     another loading request before the prior request is finished; therefore in
     such cases the delegate should be prepared to manage multiple loading
     requests.
     */
    public func resourceLoader(_ resourceLoader: AVAssetResourceLoader, shouldWaitForRenewalOfRequestedResource renewalRequest: AVAssetResourceRenewalRequest) -> Bool {
        
        print("\(#function) was called in AssetLoaderDelegate with renewalRequest: \(renewalRequest)")
        
        return shouldLoadOrRenewRequestedResource(resourceLoadingRequest: renewalRequest)
    }
}

