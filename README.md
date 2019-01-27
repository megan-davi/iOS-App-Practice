# iOS-App-Practice
iOS apps created in conjunction with The App Brewery's [Udemy iOS 12 Course](https://www.udemy.com/ios-12-app-development-bootcamp/learn/v4/content)

See folders for screenshots of applications.

### 01 :: I Am Rich
This is a simple app which displays an image and a label. Based off of the thousand-dollar-app which sold eight times on the App Store. Created in order to gain a good understanding of Xcode and how image views interface with the IDE. 

### 02 :: Dicee
This app allows the user to roll two dice when a button is pressed. The dice will also roll when a user shakes their phone. Created as an introduction to Swift code as well as to understand how code interfaces with the app views. This also utiilizes a method to run the same set of code in multiple places throughout the document.

### 02.5 :: Swift Practice file
Contains three functions for some practice in Swift before creating more apps. The first function calculates a BMI using an if-else statement, the second writes a song using a loop, and the third loops through the fibonacci sequence recursively. 

### 03 :: Xylophone
When a xylophone button is pressed, one of seven different notes is played. This was used as an introduction to searching for a built-in method that Swift provides, which was AVAudioPlayer in this case. This is my first app to use a do-catch block as well as troubleshoot error messages with [osstatus](https://osstatus.com), a third-party tool. 

### 04 :: Quizzler
This app allows a user to click through a quiz app answering true or false questions. The most important take-away from building this app is understanding how the model-view-controller design can be implemented in iOS apps. Learning points in this app include UI alerts (pop-up messages), accessing arrays and troubleshooting related bugs, and accessing a [third-party library](https://github.com/relatedcode/ProgressHUD) to show a head-up display for the user.

### 05 :: Destini
A "Choose Your Own Adventure Game" which allows a user to click through different scenarios of a story. This was mostly created to solidify knowledge gained thus far. Newest code feature is hiding buttons at the end of each story line. 

### 06 :: Calculator
This app is not functional; it served as an introduction to setting constraints via alignment and pinning so that all future apps can look great on any screen size or alignment. This calculator mimics the look of the default Mac calculator. 

### 07 :: Clima
This app will first ask a user for permission to locate them for a weather forecast. The weather will display as a temperature in celsius or fahrenheit based on a toggle and display an icon depicting the current conditions. On a linked view controller, the user can select a new city to view its weather, and see it on the first view. Building this app taught me many things: how to install and use Cocoapods (Alamofire http templating and SwiftyJSON json parsing), how protocols and delegates allow for view controllers to send data to one another, how to use Swift's powerful locationManager class and the CoreLocation Weather API, as well as how to better organize code using pragma marks. It also served as a great introduction for creating segues. 

### 08 :: Bitcoin Ticker
This app allows for a user to scroll through a list of currencies and see what a bitcoin is worth for the selected currency. The main goal of this app was to solidy knowledge gained from the Clima app; using protocols and delegates can be really tricky at first but Xcode's tooltip for using a UIPickerView told me that I needed a protocol and what required methods the delegate needed to operate. This app utilizes the [Bitcoin Average API](https://apiv2.bitcoinaverage.com). 
