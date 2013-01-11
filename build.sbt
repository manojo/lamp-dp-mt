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

// add LibRNA wrapper to sources (absolute file avoids multiple compilation)
managedSources in Compile ++= List(file("src/librna/LibRNA.scala").getAbsoluteFile)

// bind LibRNA JNI before compile
compile in Compile <<= (compile in Compile) map { x => ("src/librna/make target/scala-2.10/classes").run.exitValue; x }

// custom commands to execute JNI and CUDA targets
{
  def t(n:String) = { val t=TaskKey[Unit](n); t.dependsOn(compile in Compile); t }
  def s(t:TaskKey[Unit],cl:String) = Seq(fullRunTask(t in Test, Test, "v4.examples."+cl ), fork in t := true, javaOptions in t += "-Xss64m")
  val (mm1,mm2,mm3,align,zuker,rnafold)=(t("mm1"),t("mm2"),t("mm3"),t("align"),t("zuker"),t("rnafold"))
  s(mm1,"MatrixMultGen") ++ s(mm2,"MatrixMultGen2") ++ s(mm3,"MatrixMultGen3") ++ s(align,"SeqAlignGen") ++ s(zuker,"Zuker") ++ s(rnafold,"RNAFold")
}
// TaskKey[Unit]("zuker") := { "scala -cp target/scala-2.10/classes v4.examples.Zuker".run.exitValue }
// http://stackoverflow.com/questions/6951261/how-to-define-tasks-to-run-with-hprof-from-sbt-0-10

// custom LMS+CUDA targets
{
  def t(n:String) = { val t=TaskKey[Unit](n); t.dependsOn(compile in Compile); t }
  def s(t:TaskKey[Unit],cl:String) = Seq(fullRunTask(t in Test, Test, "lms."+cl ), fork in t := true, javaOptions in t += "-Xss64m")
  val mml=t("mml")
  s(mml,"LMSMatrixAlgebraGen")
}
