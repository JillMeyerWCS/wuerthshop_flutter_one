# Flutter Würthshop Part one

Welcome to the flutter würthshop part one.

## Step 5

We were able to load the xml as a string, but we can't work with that.
That's why we need to import an other package: [xml](https://pub.dev/packages/xml).

After we processed the xml and extracted the necessary data, replace the mock data in the result list with the first 10 diaries approved in germany for processing milk.

Try adding a `DairyFactory` class to handle the parsed data that implements `Comparable<DairyFactory>`. This is to sort the results later by name of factory.

![](./Result.png)