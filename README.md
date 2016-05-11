## YAWA Weather

#### History
The app received the name 'YAWA' because this is, in fact, 'Yet Another Weather App'. A place I had worked at years back 
started to name their subdomains with this same convention and I guess it stuck. YADSU!

#### Purpose
This app was created in order to demo my abilities for creating a production release quality app. This app started out 
simple, and grew into something more complicated as I coded. tested, and formulated my own 'wish list'. The app 
demonstrates everything great about iOS. From Swift 2.0, Storyboards, best coding practices, MVC, error handling, 
multi-threading and background downloading, Location classes, usage of 3rd party Public API's (APIs supplied by Google and 
OpenWeatherMap.org), clean design strategy, custom Launch files, and user defaults. It's all in here!


#### Setup
To build and test this app you will need to obtain API keys from OpenWeatherMap.org and from Google (as well as to enable 
the Google Maps Time Zone API and Google Places API Web Service).

##### Google API Setup 
1. Go to the [Google Developers Console](https://console.developers.google.com/)
2. Select a project or create a new one
3. Enable the Google Places API Web Service and the Google Maps Time Zone API
4. Select the API Manager button in the top left
5. Select the Enabled APIs link in the API section to see a list of all your enabled APIs. Make sure that the APIs above are 
on the list of enabled APIs
6. Add Credentials -> API Key -> iOS Key
7. Do not add anything for "Accepts requests from ... bundle identifiers"


##### Open Weather API Setup 
1. Go to the [Open Weather Map website](http://www.openweathermap.org/)
2. Select 'Sign Up' from the top of the document
3. After completing registration you can retrieve your API key from the manage account section


##### Project Setup
Add your keys to the project:

1. Open the project using the file that was created by CocoaPods (YAWA-Weather.xcworkspace), NOT the xcode project file!
2. Navigate to AppConstants.swift within the utils folder
3. Replace the value for GOOGLE_API_KEY with your API key
4. Replace the value for WEATHER_API_KEY with your API key

