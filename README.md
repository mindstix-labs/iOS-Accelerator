Mindstix iOS Accelerator
========================

## About

Mindstix iOS Accelerator is a baseline framework for iOS. It helps any iOS developer to kickstart native iOS application development.

## Features

Baseline framework provides,

* Basic directory structure for iOS application project.
* Build schemes - Demo, Dev, QA, Prod.
* Localisation support.
* Network layer using Alamofire.
* Analytics integration using Google Firebase Analytics.
* Crashlytics integration using Google Firebase Crashlytics.
* Sample service integration using OpenWeatherMap Weather and Forecast APIs.
* Sample view showing Weather information fetched from API.

## Installation
### CocoaPods

If you do not have CocoaPods installed, you can use [CocoaPods](http://cocoapods.org/). It is a dependency manager for Objective-C and Swift, which automates and simplifies the process of using 3rd-party libraries  in your projects.

Then, run the following command:

```bash
$ pod install
```

## Developer Guide
* Replace bundle identifier in app settings with your required bundle identifier.
* For Firebase Crashlytics and Analytics to work in your app, you need to login to [Firebase Console][firebase-console]. Create your app by simply providing application package.
* Replace Firebase Analytics and Crashlytics configuration file 'GoogleService-Info.plist' under 'Firebase' folder with your Firebase configuration file. Get started [here][firebase-crashlytics].
* Replace UIViewController with your required controller.
* Replace WeatherDetailsModel and ForecastDetailsModel with your required models.

## Releases

Version 0.1 - 3rd January 2018.

* Basic directory structure for iOS application project.
* Build schemes - Demo, Dev, QA, Prod.
* Localisation support.
* Network layer using Alamofire.
* Analytics integration using Google Firebase Analytics.
* Crashlytics integration using Google Firebase Crashlytics.
* Sample service integration using OpenWeatherMap Weather and Forecast APIs.
* Sample view showing Weather information fetched from API.

## Pipeline

* Local Storage Access APIs - User defaults, SQLite, coredata
* Push Notification integration - Firebase.
* Utilities.
* Unit test coverage.

## License

MIT License

Copyright (c) 2017-18 Mindstix Software Labs, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[firebase-console]: https://firebase.google.com/console/
[firebase-crashlytics]: https://firebase.google.com/docs/crashlytics/
