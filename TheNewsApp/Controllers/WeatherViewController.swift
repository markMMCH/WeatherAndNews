

import UIKit

struct Weather {
    var temperature: Double
    var condition: Int
}


class WeatherViewController: UIViewController {
    
    let weatherURL = "https://openweathermap.org/data/2.5/weather?q="
    let appID = "&appid=b6907d289e10d714a6e88b30761fae22"
    
    var weather: Weather = Weather(temperature: 0, condition: 0)
    
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colors: [#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
    }
    
    
    
    @IBAction func getWeatherButtonTapped(_ sender: UIButton) {
        
        
        let url = URL(string: weatherURL + cityTextField.text! + appID)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                guard let jsonArray = json as? [String: Any] else {
                    return
                }
                
                guard let main_info = jsonArray["main"]! as? [String: Double] else { return }
                guard let weather_info = jsonArray["weather"] as? [[String: Any]] else { return }
                
                self.weather.temperature = main_info["temp"]!
                self.weather.condition = weather_info[0]["id"]! as! Int
                print(self.weather.temperature)
                print(self.weather.condition)
                DispatchQueue.main.async {
                    self.temperatureLabel.text = String(self.weather.temperature)
                    self.weatherImageView.image = UIImage(named: self.updateWeatherIcon(condition: self.weather.condition))
                }
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            }.resume()
    }
    
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
}
