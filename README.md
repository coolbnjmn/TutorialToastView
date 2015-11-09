# TutorialToastView
A simple flexible view that animates into view when presented, showing some status or alert to your users. 

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
self.toastView = TutorialToastView(superviewFrame: view.frame, scale: (1/3), title: "TITLE", subtitle: "subtitle", defaultStyle: .Light, completion: {
   self.toastView?.removeFromSuperview()
})
```
This will create a toast view and set it to the toastView property of your ViewController. As of right now, these views do not auto-dismiss, although this is a feature I am currently investigating. Therefore, you must pass a reference to dismiss the view in the completion block. This will be fixed soon. 

The style parameter can also change, and can be either Light or Dark, the two built in styles that use default fonts along with black/white colors, or you can style the toast view any way you want with the custom style way:

```
let style = TutorialToastViewStyle(backgroundColor: BACKGROUNDCOLORHERE, tintColor: TINTCOLORHERE, font: FONTHERE)
self.toastView = TutorialToastView(superviewFrame: view.frame, scale: (1/3), title: "TITLE", subtitle: "subtitle", style: style, completion: {
  self.toastView?.removeFromSuperview()
})
```
In addition to this customized styling method, you can even go in and modify the size of the paddings and button size, by doing the following:

```
let style = TutorialToastViewStyle(backgroundColor: BACKGROUNDCOLORHERE, tintColor: TINTCOLORHERE, font: FONTHERE, padding: PADDINGHERE, closeButtonSize: CLOSEBUTTONSIZEHERE)
self.toastView = TutorialToastView(superviewFrame: view.frame, scale: (1/3), title: "TITLE", subtitle: "subtitle", style: style, completion: {
  self.toastView?.removeFromSuperview()
})
```

### Presentation
To then present your toast view, you can either manually animate the subview in, OR you can use the handy method built into `TutorialToastView` : 

```
                TutorialToastView.presentTutorialToastView(toastView, superView: view)

```

## Warnings
Make sure you're completion block handles dismissal and removal of the subview from it's superview. This is key as of today's release, and will change soon. 
Scale parameter, which controls how big the tutorial view is going to be, should be between 0 and 1. Any scale larger than 1 will not be able to get dismissed, and this is a known bug that will be fixed. 

## In the Pipeline
- Fixes to the above warnings
- Animated dismissal
- Ability to pass an animation block that is more custom
- More customization


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
