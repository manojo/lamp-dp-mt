name := "lamp-dp-mt"

resolvers ++= Seq(
  ScalaToolsSnapshots,
  //needed for custom build of scala test
  "ScalaTest" at "https://oss.sonatype.org/content/groups/public"
)

scalaOrganization := "org.scala-lang.virtualized"

scalaVersion := "2.10.0-RC2"

libraryDependencies ++= Seq(
    "org.scalatest" % "scalatest_2.10.0-RC2" % "2.0.M4-B2" % "test",
    "EPFL" %% "lms" % "0.3-SNAPSHOT")


//making tests non-parallelly executable for now
parallelExecution in Test := false

scalacOptions += "-Yvirtualize"

scalacOptions ++= List("-deprecation", "-feature", "-unchecked")
