# Run the project

### Run the server

`cd server`  
`npm i`  
`npm run dev`

### Run the Flutter app

Put your `ip address` in the `httpLink`
`flutter pub get`  
`flutter run`

### Problem

Refetch bug after two airplane mode.

How to reproduce:  
After the app has started:  
-turn on airplane mode.  
-click the refresh button.  
-turn off airplane mode.  
-click the refresh button.  
-turn on airplane mode.  
-click the refresh button.  
We are stuck loading.  
