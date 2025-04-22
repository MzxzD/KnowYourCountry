# KnowYourCountry

## About

A simple app about countries using SwiftUI, RxSwift, RxFlow, Swinject and Alamofire

## Instalation

Just download the code, open the project and wait for the SPM to resolve

## Usage

On initial launch, you'll be Navigated to TabView with ALL the countries as fist tab

<img src="assets/Screenshot 2025-04-22 at 09.25.47.png" width="310" height="600">

The second tab shows the Europe countries (the View and VM has been completly reused for those two views, only different Service has been used to call the API)

<img src="assets/Screenshot 2025-04-22 at 09.26.05" width="310" height="600">

On the top there's search functionality for easier search for specific country

<img src="assets/Screenshot 2025-04-22 at 09.26.19" width="310" height="600">

In case there's no country that fits the name search, the UI will tell you

<img src="assets/Screenshot 2025-04-22 at 09.26.37" width="310" height="600">

In case of errors, you'll receive alert of the error with description

<img src="assets/Screenshot 2025-04-22 at 09.27.11" width="310" height="600">

also in case of errors and not receiving the list, the UI will tell you to pull to refresh

<img src="assets/Screenshot 2025-04-22 at 09.27.30" width="310" height="600">

## Todo

- [ ] Maybe add a better, user friendly error messages?
- [ ] Check for edge cases
- [ ] Lint
- [ ] More Tests?


## Summary

Really happy how the app turned out. Had some difficulties with integrating RxSwift functionality with SwiftUI, but it looks like it was good as it was implemented. Would be nice to wrap them with Combine & Async so it's more clearly separated.
 

