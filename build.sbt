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

// Adding LibRNA to Scala sources
// We need the absolute file to avoid multiple compilation
managedSources in Compile ++= List(file("src/librna/LibRNA.scala").getAbsoluteFile)

TaskKey[Unit]("librna") := {
  val out = "target/scala-2.10/classes" // see (classDirectory in Compile)
  // nothing is easier than a shellscript compared to SBT vodoo
  ("src/librna/make "+out).run.exitValue
}

TaskKey[Unit]("zuker") := {
  // XXX: improve this
  "/Developer/Scala/bin/scala -cp target/scala-2.10/classes v4.examples.Zuker".run.exitValue
}
