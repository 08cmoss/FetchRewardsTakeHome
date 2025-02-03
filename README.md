### Summary: Include screen shots or a video of your app highlighting its features 
![Simulator Screenshot - iPhone 16 Pro - 2025-02-03 at 13 41 31 Small](https://github.com/user-attachments/assets/2d5b4b93-bd52-4195-857b-95585c3b0f3b)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I chose to focus more time on image caching with fallbacks. First attempting to fetch from the memory cache, then the disk, and if no image was found, finally fetching it from the network.  This seemed to be a main focus in both product requirements and unit testing.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent 3-4 hours on this project. I broke up my time into service layer implementation, image caching, UI implementation, and then testing.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I decided to not implement any cache expiration policies for the sake of time.
I also decided to use the `MockURLProtocol` to stub out the malformed and empty responses rather than hit the network, even though I included them in the `Routes` enum in `APIService`.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I think my weakest part is how little time I spent building out complex SwiftUI layouts. I believe due to the capabilities of SwiftUI previews and the speed at which I could make these updates, my time was better spent on the caching layer.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I added a navigation stack that could be utilized when a user taps on a particular recipe, but I still think UIKit navigation controllers are a little more battle tested. In production, I would typically use a `UINavigationController` and host the SwiftUI views inside, to handle navigation.
