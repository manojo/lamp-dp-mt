Lamp-DP-MT
============

## Setup instructions for running LMS
1. Locally publish [lms](https://github.com/tiarkrompf/virtualization-lms-core)
    * `$ git clone https://github.com/TiarkRompf/virtualization-lms-core.git`
    * `$ cd virtualization-lms-core`
    * `$ git checkout develop`
    * patch `project/Build.scala`:
        * `val scalaTest = "org.scalatest" % "scalatest_2.10.0" % "2.0.M5" % "test"`
        * `val virtScala = Option(System.getenv("SCALA_VIRTUALIZED_VERSION")).getOrElse("2.10.0")`
    * patch `project/build.properties`:
        * `sbt.version=0.12.1`
    * `$ sbt publish-local`
2. Run the optional [tutorial](https://github.com/julienrf/lms-tutorial)
    * `$ git clone https://github.com/julienrf/lms-tutorial.git`
    * `$ cd lms-tutorial && sbt run tutorial.Usage`

## Setup instructions for running the project
1. Checkout
    * `$ git clone https://github.com/manojo/lamp-dp-mt.git`
    * `$ cd lamp-dp-mt`
2. Run Scala parsers (with SBT)
    * Run simple tests: `$ sbt 'clean' 'librna' 'run-main v4.examples.Tests'`
    * Run any program: `$ sbt run`
    * Run Zuker folding: `$ sbt compile zuker`
    * Run RNAFold: `$ sbt compile rnafold`
    * Note that ou can run only one instance of zuker/rnafold sbt/JVM instance due to JNI unloading issues
3. Run CUDA parsers (without SBT)
    * Run CUDA tests: `$ ./build`
    * Cleanup: `$ ./build clean`
    * Get the program list: `$ ./build help` those ending with Gen are CUDA-enabled
    * Run a program with: `$ ./build <class>`
