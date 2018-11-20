
[![Build Status](https://travis-ci.org/cyber-dojo/starter.svg?branch=master)](https://travis-ci.org/cyber-dojo/starter)

<img src="https://raw.githubusercontent.com/cyber-dojo/nginx/master/images/home_page_logo.png"
alt="cyber-dojo yin/yang logo" width="50px" height="50px"/>

# cyberdojo/starter docker image

- A docker-containerized micro-service for [cyber-dojo](http://cyber-dojo.org).
- Holds the start-point files used when setting up a practice session.

API:
  * All methods receive their named arguments in a json hash.
  * All methods return a json hash.
    * If the method completes, a key equals the method's name.
    * If the method raises an exception, a key equals "exception".

- - - -

## GET sha
Returns the git commit sha used to create the docker image.
- parameters, none
```
  {}
```
- returns the sha, eg
```
  { "sha": "b28b3e13c0778fe409a50d23628f631f87920ce5" }
```

- - - -

## GET language_start_points
- parameters, none
```
  {}
```
- returns two arrays; the language-test-framework display_names and the exercises names
for the starter service's currently installed languages start-point, eg
```
  { "language_start_points": {
      "languages": [
        "C (gcc), assert",
        "C#, NUnit",
        "C++ (g++), assert",
        "Python, py.test",
        "Python, unittest"
      ],
      "exercises": [
        "Bowling_Game",
        "Fizz_Buzz",
        "Leap_Years",
        "Tiny_Maze"
      ]
    }
  }
```

- - - -

## GET language_manifest
- parameters, display_name and exercise_name from a previous call to
the language_start_points method above, eg
```
  {  "display_name": "C#, NUnit",
     "exercise_name": "Fizz_Buzz"
  }
```
- returns, the manifest for the given display_name
and the exercise instructions text for the given exercise_name, eg
```
  { "language_manifest": {
       "manifest": {
          "display_name": "C#, NUNit",
          "image_name": "cyberdojofoundation/csharp_nunit",
          "runner_choice": "stateless",
          "filename_extension": [ ".cs" ],
          "visible_files": {
             "Hiker.cs": {               
               "content" => "public class Hiker..."
             },
             "HikerTest.cs": {
               "content" => "using NUnit.Framework;..."
             },
             "cyber-dojo.sh": {
               "content" => "NUNIT_PATH=/nunit/lib/net45..."
             }
          }
       },
       "exercise": "Write a program that prints..."
    }
  }
```

- - - -

## GET custom_start_points
- parameters, none
```
  {}
```
- returns an array of the display_names for the starter service's currently installed
custom start-point, eg
```
  { "custom_start_points": [
      "Yahtzee refactoring, C# NUnit",
      "Yahtzee refactoring, C++ (g++) assert",
      "Yahtzee refactoring, Java JUnit",
      "Yahtzee refactoring, Python unitttest"
    ]
  }
```

- - - -

## GET custom_manifest
- parameter, display_name from a previous call to the custom_start_points method above, eg
```
  {  "display_name": "Yahtzee refactoring, C# NUnit"
  }
```
- returns, the manifest for the given display_name, eg
```
  { "custom_manifest": {
       "display_name": "Yahtzee refactoring, C# NUnit",
       "image_name": "cyberdojofoundation/csharp_nunit",
       "runner_choice": "stateless",
       "filename_extension": [".cs"],
       "visible_files": {
          "Yahtzee.cs": {
            "content"= > "public class Yahtzee {..."
          },
          "YahtzeeTest.cs": {
            "content"= > "using NUnit.Framework;..."
          },
          "cyber-dojo.sh": {
            "content"= > "NUNIT_PATH=/nunit/lib/net45..."
          }
          "instructions": {
            "content"= > "The starting code..."
          }
       }
    }
  }
```

- - - -

# build the docker images
Builds the starter-server image and an example starter-client image.
```
$ ./sh/build_docker_images.sh
```

# bring up the docker containers
Brings up a starter-server container and a starter-client container.

```
$ ./sh/docker_containers_up.sh
```

# run the tests
Runs the starter-server's tests from inside a starter-server container
and then the starter-client's tests from inside the starter-client container.
```
$ ./sh/run_tests_in_containers.sh
```

# run the demo
```
$ ./sh/run_demo.sh
```
Runs inside the starter-client's container.
Calls the starter-server's micro-service methods
and displays their json results and how long they took.
If the starter-client's IP address is 192.168.99.100 then put
192.168.99.100:4598 into your browser to see the output.

# demo screenshot

- - - -

* [Take me to cyber-dojo's home github repo](https://github.com/cyber-dojo/cyber-dojo).
* [Take me to the http://cyber-dojo.org site](http://cyber-dojo.org).

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snapshot.png)
