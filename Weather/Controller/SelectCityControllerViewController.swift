//
//  SelectCityControllerViewController.swift
//  Weather
//
//  Created by jas chen on 2020/1/6.
//  Copyright © 2020 jas chen. All rights reserved.
//

import UIKit

protocol SelectCityDelegate {
    func didChangeCity(city: String)
}

class SelectCityControllerViewController: UIViewController {
    //可选类型，事件可能不发生。
    var delegate:SelectCityDelegate?
    
    
    var currentCity = ""
    
    @IBOutlet weak var currentCityLabel: UILabel!
    
    @IBOutlet weak var inputCity: UITextField!
    
    
    @IBOutlet weak var changeCity: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currentCityLabel.text = currentCity
    }
    
    
    @IBAction func changeCity(_ sender: Any) {
        delegate?.didChangeCity(city: inputCity.text ?? currentCityLabel.text!)
    }
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
