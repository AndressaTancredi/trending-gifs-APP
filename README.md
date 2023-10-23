# Trending Gifs App

This is a Flutter application that displays the most popular gifs from the Giphy API. The app is built using Bloc and Cubit for state management.

![Untitled2](https://github.com/AndressaTancredi/trending-gifs-APP/assets/48730376/890b265e-e9e8-470f-be6a-f7bad1ee2eee)

## Contents

- [How to Run the App](#how-to-run-the-app)
- [Features](#features)
- [Design Decisions](#design-decisions)
- [Tech Stack](#tech-stack)

## How to Run the App

To run this app on your device, follow the steps below:

### Prerequisites

- Make sure you have Flutter and Dart installed on your system. If they are not installed, follow the Flutter installation guide on the [official website](https://flutter.dev/docs/get-started/install).

### Installation

1. Clone this repository to your development environment:


    git clone https://github.com/your-username/repository-name.git 

2. Navigate to the project directory:
   

    cd repository-name

4.  Run the app with Flutter:


    flutter run

This will start the app on your device or emulator Android/ IOS.

Type an input and press the Enter key to search for a GIF.

### Features

* Displays the most popular gifs from the Giphy API.
* Supports real-time searching and updating.
* Uses Bloc and Cubit for state management.

### Design Decisions

While developing the app, the following design decisions were made:

* Two-column layout for a better viewing experience.
* The height of each gif is determined by the height property in the API response.
* Use of loading spinners and error messages to provide a smooth user experience.

### Tech Stack

This Flutter project utilizes various packages and libraries to achieve its functionality. Here's a breakdown of the key dependencies:

- **Bloc and Flutter Bloc**: Bloc is at the heart of this application's state management. The Flutter Bloc package extends Bloc and is used to handle the app's state effectively. Cubit plays a significant role in managing the app's state, especially in scenarios like:

  - Loading the initial trending gifs.
  - Searching for gifs.
  - Handling state changes when the search completes.
  - Managing error states when no results are found.

Cubit provides a clear and structured way to manage the app's state, making it easy to handle asynchronous operations and UI updates, resulting in a smooth and responsive user experience.


- **HTTP**: The HTTP package is used to make API requests to the Giphy API, fetching data to display on the app's user interface.

- **Flutter Staggered Grid View**: This package is used to create the two-column layout in the app, providing a visually appealing way to display the gifs. It is especially useful for handling varying gif heights.

- **Cached Network Image**: Cached Network Image is used to efficiently load and cache images, ensuring smooth and fast loading of gifs in the app.

- **Flutter Dotenv**: The Flutter Dotenv package is used for managing environment variables. It securely loads API keys and other sensitive data from a .env file in the app's assets.

All of these packages are essential in building a performant, visually pleasing, and smoothly functioning app for displaying trending gifs from the Giphy API.



Made with ❤ by Andressa Tancredi.
