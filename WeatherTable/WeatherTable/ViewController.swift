//
//  ViewController.swift
//  WeatherTable
//
//  Created by Tony Park on 2017-01-25.
//  Copyright © 2017 map523. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
//    var datalist:[[String:String]] = [] // [[:]] will give one garbage data
    //for xml parsing
//    var detaildata:[String:String] = [:]
//    var elementTemp:String = ""
//    //for removing empty
//    var blank:Bool = false
    
    //For JSON
    var datalist = NSDictionary()//var datalist:[String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //dictionary : key : value
        //        let dict1 = ["지역":"한국","날씨":"비"]
        //        let dict2 = ["지역":"일본","날씨":"맑음"]
        //        let dict3 = ["지역":"중국","날씨":"눈"]
        //        let dict4 = ["지역":"스페인","날씨":"우박"]
        //        let dict5 = ["지역":"미국","날씨":"흐림"]
        //        let dict6 = ["지역":"영국","날씨":"비"]
        //        let dict7 = ["지역":"프랑스","날씨":"흐림"]
        //        let dict8 = ["지역":"브라질","날씨":"우박"]
        //        let dict9 = ["지역":"스위스","날씨":"맑음"]
        //        let dict10 = ["지역":"덴마크","날씨":"비"]
        //        let dict11 = ["지역":"스웨덴","날씨":"눈"]
        //        let dict12 = ["지역":"네덜란드","날씨":"비"]
        //        let dict13 = ["지역":"크로아티아","날씨":"맑음"]
        //        let dict14 = ["지역":"필리핀","날씨":"맑음"]
        //        let dict15 = ["지역":"독일","날씨":"눈"]
        //        let dict16 = ["지역":"헝가리","날씨":"비"]
        //        let dict17 = ["지역":"벨기에","날씨":"흐림"]
        //        let dict18 = ["지역":"핀란드","날씨":"우박"]
        //        let dict19 = ["지역":"이탈리아","날씨":"맑음"]
        
//        datalist = [dict1,dict2,dict3,dict4,dict5,dict6,dict7,dict8,dict9,dict10,dict11,dict12,dict13,dict14,dict15,dict16,dict17,dict18,dict19]
        
        //XML Parser
//        let baseURL = "https://raw.githubusercontent.com/tonypark0403/iphonewithswift2/master/weather.xml"
//        let parser = XMLParser(contentsOf: URL(string: baseURL)!)

//        parser!.delegate = self
//        parser!.parse()
        //JSON Parser
        let baseURL = URL(string:"https://raw.githubusercontent.com/tonypark0403/iphonewithswift2/master/weather.json")

        //class func jsonObject(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> Any
        //because of throws, we need do ~ catch

        do {
            self.datalist =  try JSONSerialization.jsonObject(with: Data(contentsOf: baseURL!), options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary// Data is NSData
                //for FYI, we need NSDictionary(provided by cocoa:foundation), not Dictionary(provided by swift)
                //Therefore, for JSON, we need NSDictionary
        } catch {
            print("Error loading Data")
        }
        
        print(self.datalist)
        
        //For test of JSON
//        let className = "\(type(of:(((datalist["weatherinfo"] as! NSDictionary)["local"]) as! NSArray).count))"
        /*
         as! is one of downcasting but including unrapping(for int?), whereas as? is just downcasting (calling child class)
         AnyObject can represent an instance of any class type, whereas Any can represent an instance of any type at all, including function types.
         */
        let className = "\(((datalist["weatherinfo"] as! NSDictionary)["local"] as! NSArray).count)"
        print("className : \(className)")

    }
    
//    //3 methods are mandatory
//    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
////        print("didStartElement : \(elementName)")
//        //for key
//        elementTemp = elementName
//        //for removing empty
//        blank = true
//    }
//    
//    func parser(_ parser: XMLParser, foundCharacters string: String) {
//        //for removing empty
//        if blank == true && elementTemp != "local" && elementTemp != "weatherinfo" {
////            print("foundCharacters : \(string)")
//            detaildata[elementTemp] = string
//        }
//        //when local -> dictionary starts
////        if elementTemp != "local" {
////            detaildata[elementTemp] = string
////        }
//    }
//    
//    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//        if elementName == "local" {
//            datalist += [detaildata]
//            print(detaildata)
//        }
//        //for removing empty
//        blank = false
//        
////        print("didEndElement : \(elementName)")
//    }
//    
//    //above 3 functions print things below
//    /*
//     <local>
//        <country>한국</country>
//        <weather>비</weather>
//        <temperature>20</temperature>
//     </local>
//     <local>
//        <country>일본</country>
//        <weather>맑음</weather>
//        <temperature>19</temperature>
//     </local>
//
//    didStartElement : local
//    foundCharacters :
//     
//    didStartElement : country
//    foundCharacters : 한국
//    didEndElement : country
//    foundCharacters :
//    
//    didStartElement : weather
//    foundCharacters : 비
//    didEndElement : weather
//    foundCharacters :
//    
//    didStartElement : temperature
//    foundCharacters : 20
//    didEndElement : temperature
//    foundCharacters :
//    
//    didEndElement : local
//    foundCharacters :
//    
//    didStartElement : local
//    foundCharacters :
//    
//    didStartElement : country
//    foundCharacters : 일본
//    didEndElement : country
//    foundCharacters :
//    
//    didStartElement : weather
//    foundCharacters : 맑음
//    didEndElement : weather
//    foundCharacters :
//    
//    didStartElement : temperature
//    foundCharacters : 19
//    didEndElement : temperature
//    foundCharacters : 
//    
//    didEndElement : local
//    foundCharacters :
//    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return datalist.count
        return ((datalist["weatherinfo"] as! NSDictionary)["local"] as! NSArray).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //casting to WeatherCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
        
        //queue -> FIFO, dequeue is for output
        //based on screen size, if there is more data for a screen, remained data would save in queue
        //If you don't match cell name,"Cell", then there is an error.
        
        //this is for data
//        print("indexPath row : \(indexPath.row)")
        
//        var dicTemp = datalist[indexPath.row] //if you have many sections, then using section as well as row
        let dicTemp = ((datalist["weatherinfo"] as! NSDictionary)["local"] as! NSArray)[indexPath.row] as! NSDictionary
        
        //for debugging
//        print(dicTemp) //debugging show first value is [:] because of initializing.
        print("dicTemp : \(dicTemp)")
        
//        cell.textLabel!.text = dicTemp["지역"] //this is label made already.
//        cell.countryLabel.text = dicTemp["country"] //XML
        cell.countryLabel.text = dicTemp["country"] as? String
//        let weatherStr = dicTemp["날씨"]
//        let weatherStr = dicTemp["weather"] //XML
        let weatherStr = dicTemp["weather"] as? String

        //detail label
//        cell.detailTextLabel!.text = weatheStr //if you want basic style, this is not needed
        cell.weatherLabel.text = weatherStr
        
//        cell.temperatureLabel.text = dicTemp["temperature"] //XML
        cell.temperatureLabel.text = dicTemp["temperature"] as? String
        
        //for image
        if weatherStr == "맑음" {
            cell.imgView.image = UIImage(named: "sunny.png")
        } else if weatherStr == "비" {
            cell.imgView.image = UIImage(named: "rainy.png")
        } else if weatherStr == "흐림" {
            cell.imgView.image = UIImage(named: "cloudy.png")
        }else if weatherStr == "눈" {
            cell.imgView.image = UIImage(named: "snow.png")
        }else {
            cell.imgView.image = UIImage(named: "blizzard.png")
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

