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
import SwiftyJSON


//继承了这个UI协议， 同时遵守协议
class ViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    
    @IBOutlet weak var locationLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let weather = Weather()
    var weatherJson : JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view. 只只执行一次
        locationManager.delegate = self //self指的是ViewController
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()//只请求一次
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = locations[0].coordinate.latitude
        let lon = locations[0].coordinate.longitude
        let paras:[String:Any] = ["lat":"\(lat)","lon":"\(lon)","appid":"214f97eb976f0447b16bc8c226e58d27"]
        
        getData(paras: paras)
               
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
        if segue.identifier == "selectCity"{
            //向下转型
            if let vc = segue.destination as? SelectCityControllerViewController{
                vc.currentCity = weather.city
                vc.delegate = self
            }
        }
        
       }
}

//拓展 分离
extension ViewController: CLLocationManagerDelegate,SelectCityDelegate{
    func didChangeCity(city: String) {
        print(city)
        let paras:[String : Any] = ["q" : "\(city)","appid":"214f97eb976f0447b16bc8c226e58d27"]
        getData(paras: paras)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    func getData(paras:[String:Any]){
        Alamofire.request("https://api.openweathermap.org/data/2.5/weather", parameters: paras).responseJSON{ response in
            if let json = response.result.value{
                self.weatherJson = JSON(json)
                self.createWeather(weatherJson: self.weatherJson)
                self.updateUI()
            }
        }
        
    }
    
    

    
    func createWeather(weatherJson:JSON){
        weather.city = weatherJson["name"].stringValue
        weather.temp = Int(round(weatherJson["main"]["temp"].doubleValue-273.15))
        weather.condition = weatherJson["weather"][0]["id"].intValue
                       
    }
    
    
    
    func updateUI(){
        //更新界面
        locationLabel.text = weather.city
        iconImage.image = UIImage(named: weather.icon)
        tempLabel.text = String(weather.temp)+"˚"
    }
    

    
    
}

