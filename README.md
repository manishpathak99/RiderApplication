# RiderApp
The main purpose of this app is to show items and on item click , it navigates to screen where it shows the annotations on Map screen.

## Pre-requisites
XCode 10.2

MAC 10.14

Swift 5.0

iOS 10.0 +

## Application Version 
1.0


## How to run this project
Open terminal and run  `pod install`

Go to project directory and run command `xed .` in terminal to open project in Xcode. 


## Architecture 
 In this application , VIPER pattern is used.
 
 
 ![Imgur Image](https://github.com/manishpathak99/RiderApplication/blob/master/Screenshots/diagram.png)
 
 
 
**V (View):**
View is responsible for the UI updates and show whatever the presenter tells it.

**I (Interactor)** The purpose of Interactor is responsible for fetching data from the model layer, and its implementation is totally independent of the user interface.All the business logic like `getting delivery data` is written inside the Interactor.

**P (Presenter)** The role of Presenter is intermediator, it gets data from interaction and passes to View. (It may be data or any user action)

**E (Entity)**  Basically it is contains the Object Model which is used by Interactor. like DeliveryModel

**R (Router)** It contains navigation logic for the application for example when user clicks on list item , it navigates to Map screen

**DataManager** - The main purpose of DataManager is to handle the data flow , it decides whether the data should come from the server or from local DB. 


#### Low level Data Flow Diagram 
Below is the low level data flow diagram -
 
 ![Imgur Image](https://github.com/manishpathak99/RiderApplication/blob/master/Screenshots/low-level-data-flow-diagram.png)

## Network Handling and Caching
The application is using Alamofire library for network API calls. when user open app , it starts fetching the data from server, after successfull response it saves the data in Realm database. If there is an error occured, something went wrong dialog appears . 

for Image caching, Application is using kingfisher library. 

## Cocoapods
Alamofire

Snapkit
  
ObjectMapper

RealmSwift

Kingfisher

NVActivityIndicatorView
##### For testing

Quick

Nimble

## SwiftLint 
- For installing Swfitlint, Follow instructions which are written in Readme file  https://github.com/realm/SwiftLint
- Run command line report `swiftlint --reporter "html" > linter.html`
- Open the .swiftlint.yml file and modify the rules if its required as per the requirement.
    
 ![Imgur Image](https://github.com/manishpathak99/RiderApplication/blob/master/Screenshots/swiftlint.png)
 
 ## Screenshots 
![Imgur Image](https://github.com/manishpathak99/RiderApplication/blob/master/Screenshots/screen1.png)

![Imgur Image](https://github.com/manishpathak99/RiderApplication/blob/master/Screenshots/screen2.png)



### NOTE: 
As few classes are part VIPER architecture , so I am leaving those classes with empty declaration like `DeliveryDetailModel` and `DeliveryDetailInteractor`. 

### Todo
0- Mocking of Alamofire Library (Facing issue in mocking the http lib)

1- UI Test Cases

