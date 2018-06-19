//
//  ViewController.swift
//  detectnetwork
//
//  Created by Mac10 on 6/19/18.
//  Copyright © 2018 Mac10. All rights reserved.
//

import UIKit
import TPCreativeSwift


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        detectNetwork()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //declare this property where it won't go out of scope relative to your listener
        let reachability = Reachability()!
        //declare this inside of viewWillAppear
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        /*
         
         reachability.stopNotifier()
         NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
         
         */
    }
    
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
        case .cellular:
            print("Reachable via Cellular")
        case .none:
            print("Network not reachable")
        }
    }
    
    
    func detectNetwork(){
        let reachabilityManager = NetworkReachabilityManager()
        reachabilityManager?.startListening()
        reachabilityManager?.listener = { _ in
            if let isNetworkReachable = reachabilityManager?.isReachable,
                isNetworkReachable == true {
                //Internet Available
                print("Internet available")
            } else {
                //Internet Not Available"
                print("Internet not available")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}






/*
 
 //declare this property where it won't go out of scope relative to your listener
 let reachability = Reachability()!
 
 reachability.whenReachable = { reachability in
 if reachability.connection == .wifi {
 print("Reachable via WiFi")
 } else {
 print("Reachable via Cellular")
 }
 }
 reachability.whenUnreachable = { _ in
 print("Not reachable")
 }
 
 do {
 try reachability.startNotifier()
 } catch {
 print("Unable to start notifier")
 }
 
 
 
 //Stop nofitier
 reachability.stopNotifier()
 
 
 */





