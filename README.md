# Flutter NewsFeed Application

This is a Flutter project implementing a simple news app that retrieves and displays the latest news articles for tech companies in English from yesterday to today using the News API ([https://newsapi.org/](https://newsapi.org/)).

# Screenshots

# Features

 - Newsfeed for latest thech companies news
 - Detail screen for every article
 - Pagination for newsfeed
 - Sequential arrangement based on company priority
 - Error handling and stateviews
 -  Remote API call and Caching for loaded data
 - Unit tests
 
## Getting Started

 1. **Clone the repository:**
 
     git clone https://github.com/Ae9on/NewsFlutterApp.git
 2. **Install dependencies:**
 
    cd flutter_news_app 
    flutter pub get
 3. **Run the app:**
 
	 flutter run

A few resources to get you started if this is your first Flutter project:

-   [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
-   [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the  [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Project Structure

The project follows a clean architecture pattern, with layers organized as follows:

-   `data` (Data layer): Handles data fetching and persistence.
-   `domain (usecases)`  (Domain layer): Represents business logic and core entities.
-   `presentation (notifiers)` (Presentation layer): Contains river pod notifiers that interacts with the domain layer.
-   `view` (Presentation layer): Contains common widgets and screens

## Third Parties

 - [Riverpod](https://riverpod.dev):  (anagram of  [Provider](https://pub.dev/packages/provider)) is a reactive caching framework for Flutter/Dart.
Using declarative and reactive programming, Riverpod takes care of a large part of your application's logic for you. It can perform network-requests with built-in error handling and caching, while automatically re-fetching data when necessary.

- [flutter_hook](https://pub.dev/packages/flutter_hooks) : Hooks are a new kind of object that manage the life-cycle of a `Widget`. They exist for one reason: increase the code-sharing _between_ widgets by removing duplicates.
 - [dio](https://pub.dev/packages/dio) : A powerful HTTP networking package for Dart/Flutter, supports Global configuration, Interceptors, FormData, Request cancellation, File uploading/downloading, Timeout, Custom adapters, Transformers, etc.
 - [intl](https://pub.dev/packages/intl) : Provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.
 - [Mockito](https://pub.dev/packages/mockito): A mock framework inspired by Mockito with APIs for Fakes, Mocks, behavior verification, and stubbing.

## A short description about "Clean Architecture"


![enter image description here](https://github.com/guilherme-v/flutter-clean-architecture-example/raw/main/art/arch_1.png?raw=true)

  
Usually, when working with this architecture, you'll come across some additional terminology such as Entities, Interface Adapters, Use Cases, DTOs, and other terms. These terms are simply names given to components that also fulfill 'single responsibilities' within the project:

-   Entities: Represent the core business objects, often reflecting real-world entities. Examples include Character, Episode, or Location classes. These entities usually correspond to real-world concepts or objects, possessing  **_properties_**  specific to them and encapsulating behavior through their own  **_methods_**. You'll be  **_reading, writting, and transforming entities throughout the layers_**
    
-   Interface Adapters: Also known as Adapters, they're responsible for bridging the gap between layers of the system,  **_facilitating the conversion and mapping of data between layers_**. There are various approaches available, such as specialized mapper classes or inheritance. The point is, by using these adapters, each layer can work with data in a format that suits better for its needs. As data moves between layers, it is mapped to a format that is suitable for the next layer. Thus, any future changes can be addressed by modifying these adapters to accommodate the updated format without impacting the layer's internals
    
-   Use Cases: Also known as Interactors,  **_they contain the core business logic and coordinate the flow of data_**. For example, they handle user login/logout, data saving or retrieval, and other functionalities. Use Case classes are typically imported and used by classes in the presentation (UI) layer. They also utilize a technique called 'inversion of control' to be independent of the data retrieval or sending mechanism, while coordinating the flow of data
    
-   Data Transfer Objects (DTOs): Are objects used for transferring data between different layers of the system. They serve as  _**simple containers that carry data**_  without any behavior or business logic
    

I recommend checking out  [this link](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html), provided by Robert C. Martin ('Uncle Bob'), which offers what today may be considered the 'official' explanation


## Riverpod for Reactive State Management

This project leverages Riverpod, a popular state management solution for Flutter applications. Riverpod offers several benefits that empower this news app:

-   **Reactive Caching:** Riverpod enables efficient caching of API responses. Data is fetched only when necessary,improving performance and reducing network calls. Changes in cached data are automatically reflected throughout the app, ensuring a smooth user experience.
-   **Data Binding:** Riverpod simplifies data binding between the UI and the application state. When the state changes,the UI automatically updates, removing the need for manual state management in widgets. This creates a more reactive and responsive user interface.
-   **State Management:** Riverpod provides a centralized location for managing application state. Data can be accessed and modified from any part of the app, eliminating the need for complex state passing mechanisms. This improves code organization and maintainability.