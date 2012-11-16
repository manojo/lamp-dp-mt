name := "lamp-dp-mt"

resolvers += ScalaToolsSnapshots

scalaOrganization := "org.scala-lang.virtualized"

scalaVersion := "2.10.0-RC2"

libraryDependencies += "EPFL" %% "lms" % "0.3-SNAPSHOT"

scalacOptions += "-Yvirtualize"
