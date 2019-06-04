# Habitat Sample Node App

This simple [Express](https://expressjs.com/) app is an example of how to package a Node.js application with Habitat. It's intended to accompany the walkthroughs on the Habitat website, but it can also be run locally on its own.

### Follow the Demos!

For the full experience, we recommend [following the demos](https://www.habitat.sh/learn/) on the Habitat website. They walk you through getting set up with Habitat, [Builder](https://bldr.habitat.sh/), automated builds and publishing to Docker Hub.

Alternatively, you can follow the instructions below if you simply want to build and run the app locally.

![habitat-sample-node-app](https://user-images.githubusercontent.com/274700/39158589-d1170792-4715-11e8-8e2a-1a2696944500.png)

### Prerequisites

To package and run this application with Habitat, you'll need to:

* [Install and configure Habitat](https://www.habitat.sh/docs/install-habitat/)
* [Install Docker](https://www.docker.com/community-edition) (if you're on Mac or Windows)
* Clone this repository:

      $ git clone https://github.com/habitat-sh/sample-node-app.git
      $ cd sample-node-app


### Setup for First-time Users

Before you can build the app, you'll need to create an origin and accompanying keys.
The quickest way to do this is by running `hab setup` [as described in the Habitat docs](https://www.habitat.sh/docs/install-habitat/#configure-workstation) and following the prompts:

```
$ hab setup
```

**Note**: The origin name you use during setup will need to be specified in the plan.sh file mentioned in the next section.

### Building the Package

From the `habitat` directory in this repository, open the `plan.sh` file. It should look like this:

```
pkg_origin=your_origin
pkg_name=sample-node-app
pkg_version="1.1.0"
pkg_deps=(core/node)
...
```
First, change the value of `pkg_origin` from `your_origin` to the origin you created in the previous section. If you're following the [demo](https://www.habitat.sh/learn/), use the origin you created in [Habitat Builder](http://bldr.habitat.sh/).

Next, let's change the version number:
```
...
pkg_version="1.1.1"
...
```

Save and close the file, then enter the Habitat Studio:

```
$ hab studio enter
```

And run a build:

```
[1][default:/src:0]# build
```

Habitat will produce a package (a `.hart` file) and place it in the `results` directory.

### Running the Package with Docker

Still in the Studio, right after the build, export that package as a Docker image:

```
[2][default:/src:0]# source results/last_build.env
[3][default:/src:0]# hab pkg export docker results/$pkg_artifact
```

Then exit the Studio:

```
[4][default:/src:0]# exit
```
And start a Docker container with your newly created image:

```
$ docker run -it -p 8000:8000 <YOUR_ORIGIN>/sample-node-app
```

Now head to http://localhost:8000 and see your running app!
