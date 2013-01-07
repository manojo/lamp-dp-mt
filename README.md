Lamp-DP-MT
============

## Setup instructions for running LMS
1. Locally publish [lms](https://github.com/tiarkrompf/virtualization-lms-core)
    * `$ git clone https://github.com/TiarkRompf/virtualization-lms-core.git`
    * `$ cd virtualization-lms-core`
    * `$ git checkout develop`
    * patch `project/Build.scala`:
      `val scalaTest = "org.scalatest" % "scalatest_2.10.0" % "2.0.M5" % "test"`
      `val virtScala = Option(System.getenv("SCALA_VIRTUALIZED_VERSION")).getOrElse("2.10.0")`
    * patch `project/build.properties`:
    * `$ sbt publish-local`

2. Run the tutorial inspired from [here](https://github.com/julienrf/lms-tutorial)
    * `$ git clone https://github.com/manojo/lamp-dp-mt.git`
    * `$ cd lms-tutorial && sbt run tutorial.Usage`


