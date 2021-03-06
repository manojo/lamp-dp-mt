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
  val yjp="/Applications/Tools/YourKit Java Profiler.app/bin/mac/libyjpagent.jnilib"
  def t(n:String) = { val t=TaskKey[Unit](n); t.dependsOn(compile in Compile); t }
  def s(t:TaskKey[Unit],cl:String) = Seq(fullRunTask(t in Test, Test, cl), fork in t:=true,javaOptions in t++=List(
    "-Xss128m" //"-Xss512m","-Xmx8G","-Xms8G","-XX:MaxPermSize=8G" //,"-verbose:gc"
    //"-agentpath:"+yjp+"=sampling,onexit=snapshot,builtinprobes=all"
  ))
  val (mm,mm2,mm3,align,zuker,z2,rnafold,nu,swat)=(t("mm"),t("mm2"),t("mm3"),t("align"),t("zuker"),t("z2"),t("rnafold"),t("nu"),t("swat")) // Examples
  val (mml,mmr,rr,bench)=(t("mml"),t("mmr"),t("rr"),t("bench")) // LMS and report
  val lt1=t("lt1") // LMS testing
  val ex="v4.examples."
  s(mm,ex+"MatrixMult") ++ s(mm2,ex+"MatrixMult2") ++ s(mm3,ex+"MatrixMult3") ++ s(align,ex+"SeqAlign") ++
  s(zuker,ex+"Zuker") ++ s(z2,ex+"Zuker2") ++ s(rnafold,ex+"RNAFold") ++ s(nu,ex+"Nussinov") ++ s(swat,ex+"SWatAffine") ++
  s(mml,"lms.LMSMatrixAlgebraGen") ++ s(mmr,"v4.report.MatrixMult8") ++ s(rr,"v4.report.RNAFold") ++ s(bench,"v4.report.Benchmarks") ++
  s(lt1,ex+"TestLMS")
}
// TaskKey[Unit]("zuker") := { "scala -cp target/scala-2.10/classes v4.examples.Zuker".run.exitValue }
// http://stackoverflow.com/questions/6951261/how-to-define-tasks-to-run-with-hprof-from-sbt-0-10

addCommandAlias("chk", ";clean;run-main v4.examples.Tests;zuker;rnafold;align;mm1;mm2;mm3")
