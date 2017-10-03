# Habitat Sample Node App

Welcome to the Habitat Sample Node App!

![habitat-sample-node-app](https://user-images.githubusercontent.com/446285/31078915-96033340-a749-11e7-906c-7861521894fc.png)


## Instructions

To practice packaging/running this app with Habitat

### Workstation Prereqs:
* Install and set up Habitat [(Instructions here)](https://www.habitat.sh/tutorials/download/)
* Install Docker [(Instructions here)](https://www.docker.com/community-edition)
* Clone this repository
```bash
$  git clone https://github.com/habitat-sh/sample-node-app.git
```
* Change directories
```bash
$ cd sample-node-app
```

### Building the Package:
You'll see a directory called habitat.  Open the habitat/plan.sh file:

Your habitat/plan.sh should look like this:
```sh
pkg_name=sample-node-app
pkg_origin=your_origin
pkg_scaffolding="core/scaffolding-node"
```

Let's add in a version number
```sh
pkg_name=sample-node-app
pkg_origin=your_origin
pkg_scaffolding="core/scaffolding-node"
pkg_version="1.0.1"
```

Now save and close the file.

Enter the Habitat Studio

```bash
$ hab studio enter
```

And run build

```bash
(studio) $ build
```

### Running the Package with Docker

Still in your studio, right after the build, export that package to a docker image
```bash
(studio) $ hab pkg export docker ./results/<habitat artifact>.hart
```

Then exit out of the studio:
```bash
(studio) $ exit
```

Now start a Docker container from that image.

```bash
$ docker run -it -p 8000:8000 your_origin/sample-node-app
```

Now head to http://localhost:8000 and see your running app!
