//
//  PlayerViewController.swift
//  OoyalaHeartbeatSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//
import AVKit
import AVFoundation
import UIKit

class PlayerViewController: AVPlayerViewController {
    
    let PING_FREQUENCY_S = 10
    let SSAI_GUID = "HeartbeatSampleTest";
    var timer : Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startPlayer()
    }
    
    func startPlayer() {
        let baseUrl = "http://ssai.ooyala.com/vhls/ltZ3l5YjE6lUAvBdflvcDQ-zti8q8Urd/RpOWUyOq86gFq-STNqpgzhzIcXHV/eyJvIjoiaHR0cDovL3BsYXllci5vb3lhbGEuY29tL3BsYXllci9hbGwvbHRaM2w1WWpFNmxVQXZCZGZsdmNEUS16dGk4cThVcmQubTN1OD90YXJnZXRCaXRyYXRlPTEyMDAmc2VjdXJlX2lvc190b2tlbj1hMWRCYWtoSVFreHNMMFJqT0ZsUFlVZ3hNRFZLTVdSNWEwbDBaSFE0VW5SVFEzWnZVM041UVdsNGRXcFFVRFpXV0VOVVUycFVUazFQTHpWb0NuVnZWM2RoVUVGR2NIUTJjbGhTVmtOYVJIaFRXRkYxUkVaM1BUMEsiLCJlIjoiMTQ5OTQ0Mjg5MiIsInMiOiJHQk9wZFhGNGNzZzhfTzJ3MVlyU2VFejVlQzhQY0h5c054LU5FRDk3cmxzPSJ9/manifest.m3u8?ssai_guid=";
        let urlString = baseUrl + SSAI_GUID
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let player = AVPlayer(url: url)
        self.player = player
        
        // Add observers
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        self.player?.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions(rawValue: 0), context: nil)

        // Show a frame
        let initTime = CMTime(seconds: 0.01, preferredTimescale: 1)
        self.player?.seek(to: initTime)
    }
    
    func startScheduledCalls() {
        if timer == nil {
            postDataToHeartbeat()
            timer = Timer.scheduledTimer(timeInterval: Double(PING_FREQUENCY_S), target: self, selector: #selector(postDataToHeartbeat), userInfo: nil, repeats: true)
        }
    }
    
    func stopScheduledCalls() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func playerDidFinishPlaying(notification: Notification) {
        postDataToHeartbeat()
        stopScheduledCalls()
    }
    
    @objc func postDataToHeartbeat() {
        let embedCode = "ltZ3l5YjE6lUAvBdflvcDQ-zti8q8Urd";
        let urlString = "http://ssai.ooyala.com/v1/vod_playback_pos/" + embedCode + "?ssai_guid=" + SSAI_GUID
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let timePassedSeconds = self.player?.currentTime().seconds ?? 0
        
        let json: [String: Int] = ["playheadpos": Int(timePassedSeconds),
                                   "pingfrequency": PING_FREQUENCY_S]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                return
            }
        }
        task.resume()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "rate", let playRate = self.player?.rate {
            if playRate == 0.0 {
                stopScheduledCalls()
            } else {
                startScheduledCalls()
            }
        }
    }
}
