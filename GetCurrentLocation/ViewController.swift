//
//  ViewController.swift
//  GetCurrentLocation
//
//  Created by Yinan on 16/3/11.
//  Copyright © 2016年 Yinan. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    var locationManager : CLLocationManager!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    /*
        1.  添加CoreLocation.framework
    
        2.  创建locationManager 设置代理实现代理方法
    
        3.  requestAlwaysAuthorization  始终允许访问位置信息
            requestWhenInUseAuthorization 使用期间允许访问
    
        4.  需在在Info.plist文件中添加如下配置：
           （1）NSLocationAlwaysUsageDescription
           （2）NSLocationWhenInUseUsageDescription
    */
    
    @IBAction func startLocation(sender: AnyObject) {
        locationManager = CLLocationManager.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest// 所需精度
        locationManager.distanceFilter = 10.0 // 距离过滤
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        locationManager.stopUpdatingLocation()
        
        let geoCoder = CLGeocoder.init()
        geoCoder.reverseGeocodeLocation(newLocation) { (placemarks, error) -> Void in
            for placemark in placemarks!{
                let testDic:NSDictionary = placemark.addressDictionary!
                self.locationLabel.text = testDic.objectForKey("State") as? String
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

