# Luiz's Notes

Hi! Thanks for sending the challenge. I've really enjoyed working on it.

Here are some notes describing decision that I made.

## Tasks

1. I decided to adopt a simple ViewModel architecture approach for this project. I chose a MVVM approach because it's easy to understand and separates concerns. Also, it can be expandable, if needed, to a VIP or even VIPER. The communication between the `ViewController` and the `ViewModel` can be done in several ways. I've used a protocol approach where we can decouple. With this approach we have some advantages:
    - Any `ViewController` or `ViewModel` class that conforms to the protocol can be used. This means that if a major change is needed in the future, we can just create a new class that conforms to the protocol. 
    - It helps when writing tests.
    - We can be sure that the ViewController and the ViewModel will have the functions implemented. While using, for example, closures as variables, we can't be sure.

2. `DeviceListViewController` lists the devices after requesting them from `DeviceService`.

3. `DeviceDetailViewController` shows the selected device from the previous screen.

4. I've added unit tests and the current coverage is 81.2%

## Notes

I created a `develop` branch to work on my changes and keep the original challenge in the `main`. There's a Pull Request open to merge `develop` into `master`

I created a Network layer based on [Moya](https://github.com/Moya/Moya). I like this approach because we can have a enum named API (in this project `DeviceAPI`) that lists all endpoints. 

