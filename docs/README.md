
* [Take me to cyber-dojo's home github repo](https://github.com/cyber-dojo/cyber-dojo).
* [Take me to the http://cyber-dojo.org site](http://cyber-dojo.org).

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snaphot.png)

- - - -

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

## GET custom_choices
blurb...
- parameters, none
```
  {}
```
- returns, eg
```
  { "custom_choices": {
      ...
    }
  }
```

- - - -

## GET languages_choices
blurb...
- parameters, none
```
  {}
```
- returns, eg
```
  { "languages_choices": {
      ...
    }
  }
```

- - - -

## GET exercises_choices
blurb...
- parameters, none
```
  {}
```
- returns, eg
```
  { "exercises_choices": {
      ...
    }
  }
```

- - - -

## GET custom_manifest
blurb...
- parameters, eg
```
  {  "major_name": "Python",
     "minor_name": "py.test"
  }
```
- returns, eg
```
  { "custom_manifest": {
      ...
    }
  }
```

- - - -

## GET language_manifest
blurb...
- parameters, eg
```
  {  "major_name": "Python",
     "minor_name": "py.test",
     "exercise_name": "Fizz_Buzz"
  }
```
- returns, eg
```
  { "language_manifest": {
      ...
    }
  }
```

- - - -

## GET manifest
blurb...
- parameters, eg
```
  {  "old_name": "C"
  }
```
- returns, eg
```
  { "manifest": {
      ...
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

![red amber green demo](red_amber_green_demo.png?raw=true "red amber green demo")
