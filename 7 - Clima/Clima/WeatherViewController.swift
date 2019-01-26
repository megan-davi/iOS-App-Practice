//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    // Variables
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "9ca91660e6d0546305d3da5fd7101832"
    var fahBoolean = false
    
    // Declare instance variables
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    //MARK: - Networking
    /***************************************************************/
    
    // get weather data using the Alamofire cocoapod (http/json templating)
    func getWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in    // in keyword denotes a closure (function w/i a function)
            if response.result.isSuccess {
                print("Success! Got the weather data." )
                let weatherJSON: JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)   // use self so that scope reaches outside of closure
            } else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }

    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateWeatherData(json: JSON) {
        // pull temp, city, and condition data from weatherDataModel
        if let tempResult = json["main"]["temp"].double {
            weatherDataModel.temperature = Int(tempResult - 273.15)
            // change city, condition, and icon
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherData()
        } else {
            cityLabel.text = "Weather unavailable"
        }
    }
    
    //MARK: - UI Updates
    /***************************************************************/
    
    // updates city, condition, and icon
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        if fahBoolean == true {
            temperatureLabel.text = "\(weatherDataModel.temperature * 9/5 + 32)°"
        } else {
            temperatureLabel.text = "\(weatherDataModel.temperature)°"
        }
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    // runs when C/F converter switch is tapped (default is C)
    @IBAction func tempSwitchTapped(_ sender: UISwitch) {
        if sender.isOn == true {
            fahBoolean = true
        } else {
            fahBoolean = false
        }
        updateUIWithWeatherData()
    }

    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    // runs when location manager successfully updates location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {                // if valid result is found,
            locationManager.stopUpdatingLocation()          // stop updating location (so as to not drain the battery)
            locationManager.delegate = nil                  // when locationManager is stopped, do not send JSON data
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            // pass parameters into a dictionary
            let params : [String: String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    // runs when location manager fails with an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    // get weather data for new city entered
    func userEnteredANewCityName(city: String) {
        let params: [String: String] = ["q": city, "appid": APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
    }

    // when "get weather" button is pressed, send user back to previous VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
}


