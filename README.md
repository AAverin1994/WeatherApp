# WeatherApp
This is a test weather app which shows the weather for 5 capitals of the world. This app use [open-meteo API](https://open-meteo.com/) for taking weather data.

![Simulator Screen Recording - iPhone 16 - 2026-03-05 at 16 09 37](https://github.com/user-attachments/assets/0242515c-c315-435f-89e6-f06cf28b3fcc)

# Technical stack

- SwiftUI
- iOS 16+
- [TaoJson](https://github.com/taocpp/json) - one header C++ library for decoding JSON
- Objective C bridging for using TaoJson decoding

# Dependencies

There are no external dependencies. Except [pegtl](https://github.com/taocpp/PEGTL) which use for TaoJson. You need install this library localy, for successfull app building.
