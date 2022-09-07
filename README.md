# Take Home

### An app that displays different types of beers (data fetched from an api).

![flutter logo](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![dart logo](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

Features:

<p align="center">
  <img src="./take_home.gif" width=200/>
</p>

- Fetches data from a public api
- Displays the data beautifully and in such an understandable manner.
- If the alcohol percentage of the beer is < 5% then it will be contained in Green color otherwise it will be contained in red Color.
- The app refreshes the data every 10 seconds.
- The bottom Floating Action Button Shows the number of seconds remaining.
- If you tap the floating action button, it will instantly refresh the data and reset the timer.
- Used flutter_spinkit library for displaying a temporary rotating circle-squaure while the data is being fetched from the internet.

Libraries used:

- flutter_spinkit: ^5.1.0
- http
