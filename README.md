# Futter_Do App

Futter_Do App is a Flutter-based task management application that helps users organize their day-to-day tasks efficiently. It utilizes Firebase for backend services, providing a seamless and responsive task management experience.

## Features

- **User Authentication**: Users can sign up with email and password or log in securely to manage their tasks.
- **Task Management**: Tasks are categorized into "Today", "Tomorrow", and "Next Week" for easy planning and organization.
- **CRUD Operations**: Create, Read, Update, and Delete tasks effortlessly.
- **Task Status Management**: Swipe right to mark tasks as completed or uncompleted and left to delete a task"
- **Intuitive User Interface**: Simple and clean design for smooth user interaction.

## Technologies Used

- **Flutter**: Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Firebase**: Google's mobile and web application development platform for backend services such as authentication, database, and hosting.

## Getting Started

To get started with Futter_Do App, follow these steps:

1. **Clone the repository**:
- git clone https://github.com/Aflah3100/Flutter_Do.git


2. **Set up Firebase**:
- Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/).
- Add your Android and iOS apps to the Firebase project (follow Firebase setup instructions).
- Download `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) from Firebase and place them into the respective directories:
  - Android: `android/app/google-services.json`
  - iOS: `ios/Runner/GoogleService-Info.plist`

3. **Set up Environment Variables**:
- Create a `.env` file in the `assets` directory of your Flutter project.
- Add your Firebase configuration to the `.env` file:
  ```plaintext
  WEB_API_KEY=your_web_api_key
  WEB_APP_ID=your_web_app_id
  ...
  ANDROID_API_KEY=your_android_api_key
  ANDROID_APP_ID=your_android_app_id
  ...
  IOS_API_KEY=your_ios_api_key
  IOS_APP_ID=your_ios_app_id
  ...
  ```

4. **Run the app**:
- flutter pub get
- flutter run

## Screenshots

### Login Screen
<img src="screenshots/login-screen.png" alt="Login Screen" width="300"/>

### Home Screen
<img src="screenshots/home-screen.png" alt="Home Screen" width="300"/>

### Home Screen Containing Tasks
<img src="screenshots/all_tasks.png" alt="Home Screen Containing Tasks" width="300"/>

### Creating or Editing Tasks
<img src="screenshots/create_new_task.png" alt="Creating or Editing Tasks" width="300"/>

### Task Marking as Completed
<img src="screenshots/task_completion.png" alt="Task Marking as Completed" width="300"/>

### Deleting a Task
<img src="screenshots/task_deletion.png" alt="Deleting a Task" width="300"/>





