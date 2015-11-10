# TutorialToastView
A simple flexible view that animates into view when presented, showing some status or alert to your users. 

![alt tag](https://github.com/coolbnjmn/TutorialToastView/blob/master/Demo.gif)

## Setup
### Initial Setup Instructions
1. Ensure you have the latest version of Xcode installed on your computer. You can find the latest release at https://developer.apple.com/xcode/downloads/

2. Install cocoapods to your Mac by opening Terminal and executing the command 
  > sudo gem install cocoapods

### Cocoa Pod Instructions
3. Add `pod 'TutorialToastView'` to your Podfile

4. Run `pod install`

## Usage
### Initial Setup Instructions
At the top of the file where you'd like to use `TutorialToastView`, insert `import TutorialToastView`

### Initialization
Create a toast view simply and easily by doing the following: 

```
self.toastView = TutorialToastView(superviewFrame: view.frame, scale: (1/3), title: "TITLE", subtitle: "subtitle", defaultStyle: .Light, animationStyle: nil, completion: {})
```
This will create a toast view and set it to the toastView property of your ViewController. As of right now, these views do not auto-dismiss, although this is a feature I am currently investigating. Therefore, you must pass a reference to dismiss the view in the completion block. This will be fixed soon. 

The style parameter can also change, and can be either Light or Dark, the two built in styles that use default fonts along with black/white colors, or you can style the toast view any way you want with the custom style way:

```
let style = TutorialToastViewStyle(backgroundColor: BACKGROUNDCOLORHERE, tintColor: TINTCOLORHERE, font: FONTHERE)
self.toastView = TutorialToastView(superviewFrame: view.frame, scale: (1/3), title: "TITLE", subtitle: "subtitle", style: style, animationStyle: nil, completion: {})
```
In addition to this customized styling method, you can even go in and modify the size of the paddings and button size, by doing the following:

```
let style = TutorialToastViewStyle(backgroundColor: BACKGROUNDCOLORHERE, tintColor: TINTCOLORHERE, font: FONTHERE, padding: PADDINGHERE, closeButtonSize: CLOSEBUTTONSIZEHERE)
self.toastView = TutorialToastView(superviewFrame: view.frame, scale: (1/3), title: "TITLE", subtitle: "subtitle", style: style, animationStyle: nil, completion: {})
```

### Presentation
To then present your toast view, you can either manually animate the subview in, OR you can use the handy method built into `TutorialToastView` : 

```
                TutorialToastView.presentTutorialToastView(toastView, superView: view)

```

## Warnings
Scale parameter, which controls how big the tutorial view is going to be, should be between 0 and 1. Any scale larger than 1 will not be able to get dismissed, and this is a known bug that will be fixed. 

## In the Pipeline
- Fixes to the above warnings
- More customization
- Instead of a colored square for the close button, use an actual image asset with a changeable tint color.

## ChangeLog
### V0.1.10
Added TutorialToastViewAnimationStyle parameter to all TutorialToastView creation calls, but you can pass nil for now. If you want to pass a custom animation style, though, you can! through these simple methods:
```
TutorialToastViewAnimationStyle.defaultAnimationStyle()
```
OR
```
TutorialToastViewAnimationStyle.customAnimationStyle(inDuration : 1, inCurve : .CurveEaseOut, outDuration: 1, outCurve : .CurveEaseIn) 
```

If this is not enough customization, let me know!

## License
Copyright (c) 2015 Benjamin Hendricks



Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:



The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.



THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
