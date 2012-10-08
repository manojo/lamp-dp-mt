Lamp-DP-MT
============

## Setup instructions for running LMS-related stuff
inspired from [here](https://github.com/julienrf/lms-tutorial)

1. Locally publish [lms](https://github.com/tiarkrompf/virtualization-lms-core)
    * `$ git clone https://github.com/TiarkRompf/virtualization-lms-core.git`
    * `$ cd virtualization-lms-core`
    * `$ git checkout delite-develop2`
    * `$ sbt publish-local`
2. Run the tutorial
    * `$ git clone https://github.com/manojo/lamp-dp-mt.git`
    * `$ cd lms-tutorial && sbt run tutorial.Usage`
