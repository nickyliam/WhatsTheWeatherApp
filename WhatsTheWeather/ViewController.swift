//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by admin on 6/6/17.
//  Copyright © 2017 KahoTestSwitft. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var forecastLabel: UILabel!
    
    @IBAction func SearchButton(_ sender: Any) {
        
//        forecastLabel.text = textField.text
        
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + textField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
            print("button pressed")
//            let request = NSMutableURLRequest(url: url)  // works as well
//            let task = URLSession.shared.dataTask(with: request as URLRequest) { // works as well
            let task = URLSession.shared.dataTask(with: url) {
  
                data, response, error in
                
                var message = ""
                
                if error != nil {
                    
                    print(error)
                    
                } else {
                    
                    if let unwrappedData = data {
                             print("processing")
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        
                        
                        let stringComparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if var contentArray = dataString?.components(separatedBy: stringComparator){
                            if contentArray.count > 1 {
                                
                                let stringComparator2 = "</span>"
                                print(contentArray[1])
                                let newContentArray = contentArray[1].components(separatedBy: stringComparator2)
                                
                                if newContentArray.count > 1 {
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "")
                                    print(message)
                                }
                                
                                
                            }
                        }
                        
                    }
                    
                    
                }
                
                if message == "" {
                    message = "The weather there couldnt be found. Please try again"
                }
                
                
                DispatchQueue.main.sync(execute: {
                    
                    self.forecastLabel.text = message
                    
                })
            }
            task.resume()
        } else {
            forecastLabel.text = "The weather there couldnt be found. Please try again"
             print("failed")
        }

        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
         
  
         
         */
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

