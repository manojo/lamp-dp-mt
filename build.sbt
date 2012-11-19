name := "lamp-dp-mt"

resolvers ++= Seq(
  ScalaToolsSnapshots,
  //needed for custom build of scala test
  "Dropbox" at "http://dl.dropbox.com/u/12870350/scala-virtualized"
)

scalaOrganization := "org.scala-lang.virtualized"

scalaVersion := "2.10.0-RC2"

libraryDependencies ++= Seq(
    "org.scalatest" % "scalatest_2.10.0-M7" % "1.9-2.10.0-M7-B1" % "test",
    //"org.scalatest" % "scalatest_2.10.0-virtualized-SNAPSHOT" % "1.6.1-SNAPSHOT" % "test",
    "EPFL" %% "lms" % "0.3-SNAPSHOT")


//making tests non-parallelly executable for now
parallelExecution in Test := false

scalacOptions += "-Yvirtualize"
