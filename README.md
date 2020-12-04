# Basic example showing distributed tracing across ruby apps
This is an example app where two sinatra (ruby) services collaborate on an http request. Notably, timing of these requests are recorded into [Zipkin](https://zipkin.io/), a distributed tracing system. This allows you to see the how long the whole operation took, as well how much time was spent in each service.

Here's an example of what it looks like
<img width="972" alt="zipkin screen shot" src="https://user-images.githubusercontent.com/64215/101130524-93c58600-363e-11eb-996f-e72885a669aa.png">

This example was ported from similar examples, such as [Brave](https://github.com/openzipkin/brave-example).

# Implementation Overview

Web requests are served by [Sinatra](http://sinatrarb.com/) routes, and tracing is automatically performed for you by [zipkin-ruby](https://github.com/OpenZipkin/zipkin-ruby).

This example has two services: frontend and backend. They both report trace data to zipkin. To setup the demo, you need to start frontend.rb, backend.rb and Zipkin.

## Setup

Before you start anything, you'll need to download the libraries used in this demo:
```bash
# get the latest version of zipkin-ruby
$ bundle update
# install the example
$ bundle install
```

You'll also want to download zipkin.
```bash
$ curl -sSL https://zipkin.io/quickstart.sh | bash -s
```

## Starting the Services
In a separate tab or window, start each of [frontend.rb](./frontend.rb) and [backend.rb](./backend.rb):
```bash
$ ruby frontend.rb
$ ruby backend.rb
```

Next, run [Zipkin](https://zipkin.io/), which stores and queries traces reported by and above services.

```bash
$ java -jar zipkin.jar
```

## Running the example

Once the services are started, open http://localhost:8081/
* This will call the backend (http://localhost:9000/api) and show the result, which defaults to a formatted date.

Now, you can view traces that went through the frontend via http://localhost:9411/?serviceName=frontend
* This is a locally run zipkin service which keeps traces in memory
