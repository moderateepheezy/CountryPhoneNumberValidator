# CountryPhoneNumberValidator

[![CI Status](http://img.shields.io/travis/moderateepheezy/CountryPhoneNumberValidator.svg?style=flat)](https://travis-ci.org/moderateepheezy/CountryPhoneNumberValidator)
[![Version](https://img.shields.io/cocoapods/v/CountryPhoneNumberValidator.svg?style=flat)](http://cocoapods.org/pods/CountryPhoneNumberValidator)
[![License](https://img.shields.io/cocoapods/l/CountryPhoneNumberValidator.svg?style=flat)](http://cocoapods.org/pods/CountryPhoneNumberValidator)
[![Platform](https://img.shields.io/cocoapods/p/CountryPhoneNumberValidator.svg?style=flat)](http://cocoapods.org/pods/CountryPhoneNumberValidator)

## Screenshot
![Alt text](https://user-images.githubusercontent.com/4386218/33623765-5e8e72d6-d9f2-11e7-851b-f0275fd1d4e1.gif "Main Screen")

## Usage
```
import CountryPhoneNumberValidator

var phoneView: PhoneNumberView!

phoneView = PhoneNumberView(vc: self, button: verifyButton)

verifyButton.addTarget(self, action: #selector(verifyPhoneNumber), for: .touchUpInside)

func verifyPhoneNumber() {
        phoneView.validate { (completed) in
            if completed {
                self.showAlert(withTitle: "Success", message: "PhoneNumber is Valid")
            }else{
                self.showAlert(withTitle: "", message: "The phone number is not valid.")
            }
        }
    }
```



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Copy *CountryPhoneNumberValidator* to your project folder

## Todo
1. Refactor PhoneNumberView for customization.
2. Improve phone number validation.
3. Make installing from cocoapod.

## Author

moderateepheezy, moderateepheezy@gmail.com

## License

CountryPhoneNumberValidator is available under the MIT license. See the LICENSE file for more info.
