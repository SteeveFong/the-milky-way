# The Milky Way

## Approach

- The project is built using MVVM architecture. 
- RxSwift was used in favor of Combine because the project required using UIKit and storyboards. RxCocoa works great with UIKit and Combine is used to it's full potential when coding with SwiftUI.
- Alamofire was used for faster network implementation.
- SDWebImage was used to cache images and contained UIImageView extensions for faster implementation.

## Improvements

- More unit testing: Api calls, View Models, UI Tests, functions etc...
- To add Internet connection listener
- More error handlers, handle specific errors individually
- Add bug reporting service
- Add analytics
- When app grow bigger, we can introduce a more modular structure together with MVVM
