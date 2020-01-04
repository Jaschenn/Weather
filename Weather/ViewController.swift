//
//  ViewController.swift
//  Weather
//
//  Created by jas chen on 2020/1/3.
//  Copyright © 2020 jas chen. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
//继承了这个UI协议， 同时遵守协议
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view. 只只执行一次
        locationManager.delegate = self //self指的是ViewController
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        locationManager.requestLocation()//只请求一次
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = locations[0].coordinate.latitude
        let lon = locations[0].coordinate.longitude
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=214f97eb976f0447b16bc8c226e58d27").responseJSON{ response in
            print("请求中")
            if let json = response.result.value{
                print("JSON:\(json)")
            }
        
        
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}

