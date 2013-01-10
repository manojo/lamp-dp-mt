name := "lamp-dp-mt"

resolvers ++= Seq(
  ScalaToolsSnapshots, //needed for custom build of scala test
  "ScalaTest" at "https://oss.sonatype.org/content/groups/public"
)

scalaOrganization := "org.scala-lang.virtualized"

scalaVersion := "2.10.0"

libraryDependencies ++= Seq(
  "org.scala-lang.virtualized" % "scala-library" % "2.10.0",
  "org.scala-lang.virtualized" % "scala-compiler" % "2.10.0",
  "org.scala-lang" % "scala-actors" % "2.10.0", // for ScalaTest
  "org.scalatest" % "scalatest_2.10.0" % "2.0.M5" % "test",
  "EPFL" % "lms_2.10.0" % "0.3-SNAPSHOT"
)

//making tests non-parallelly executable for now
parallelExecution in Test := false

scalacOptions ++= List("-Yvirtualize", "-target:jvm-1.7", "-optimise", "-deprecation", "-feature", "-unchecked")

// Add LibRNA to Scala sources (we need absolute file to avoid multiple compilation)
managedSources in Compile ++= List(file("src/librna/LibRNA.scala").getAbsoluteFile)

// Bind LibRNA JNI before compile
compile in Compile <<= (compile in Compile) map { x =>
  ("src/librna/make target/scala-2.10/classes").run.exitValue; x
}

// Custom commands to compile JNI and CUDA targets
{
  lazy val mm1 = TaskKey[Unit]("mm1")
  lazy val mm2 = TaskKey[Unit]("mm2")
  lazy val mm3 = TaskKey[Unit]("mm3")
  lazy val align = TaskKey[Unit]("align")
  lazy val zuker = TaskKey[Unit]("zuker")
  lazy val rnafold = TaskKey[Unit]("rnafold")
  seq(
    fullRunTask(mm1 in Test, Test, "v4.examples.MatrixMultGen" ), fork in mm1 := true, javaOptions in mm1 += "-Xss64m",
    fullRunTask(mm2 in Test, Test, "v4.examples.MatrixMultGen2"), fork in mm2 := true, javaOptions in mm2 += "-Xss64m",
    fullRunTask(mm3 in Test, Test, "v4.examples.MatrixMultGen3"), fork in mm3 := true, javaOptions in mm3 += "-Xss64m",
    fullRunTask(align in Test, Test, "v4.examples.SeqAlignGen"), fork in align := true, javaOptions in align += "-Xss64m",
    fullRunTask(zuker in Test, Test, "v4.examples.Zuker"), fork in zuker := true, javaOptions in zuker += "-Xss64m",
    fullRunTask(rnafold in Test, Test, "v4.examples.RNAFold"), fork in rnafold := true, javaOptions in rnafold += "-Xss64m"
  )
}
// TaskKey[Unit]("zuker") := { "scala -cp target/scala-2.10/classes v4.examples.Zuker".run.exitValue }
// http://stackoverflow.com/questions/6951261/how-to-define-tasks-to-run-with-hprof-from-sbt-0-10
