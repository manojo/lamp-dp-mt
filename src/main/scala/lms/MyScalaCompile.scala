package lms

import scala.virtualization.lms.internal._
import java.io._

import scala.tools.nsc._
import scala.tools.nsc.util._
import scala.tools.nsc.reporters._
import scala.tools.nsc.io._

import scala.tools.nsc.interpreter.AbstractFileClassLoader


trait MyScalaCompile extends ScalaCompile {

  override val codegen: ScalaCodegen { val IR: MyScalaCompile.this.type }

  def compile2[A,B,R](f: (Exp[A], Exp[B]) => Exp[R])(implicit mA: Manifest[A], mB: Manifest[B], mR: Manifest[R]): (A,B)=>R = {
    if (this.compiler eq null)
      setupCompiler()

    val className = "staged$" + compileCount
    compileCount += 1

    val source = new StringWriter()
    val staticData = codegen.emitSource2(f, className, new PrintWriter(source))

    if (dumpGeneratedCode) println(source)

    val compiler = this.compiler
    val run = new compiler.Run

    val fileSystem = new VirtualDirectory("<vfs>", None)
    compiler.settings.outputDirs.setSingleOutput(fileSystem)
  //      compiler.genJVM.outputDir = fileSystem

    run.compileSources(List(new util.BatchSourceFile("<stdin>", source.toString)))
    reporter.printSummary()

    if (!reporter.hasErrors)
      println("compilation: ok")
    else
      println("compilation: had errors")

    reporter.reset
    //output.reset

    val parent = this.getClass.getClassLoader
    val loader = new AbstractFileClassLoader(fileSystem, this.getClass.getClassLoader)

    val cls: Class[_] = loader.loadClass(className)
    val cons = cls.getConstructor(staticData.map(_._1.tp.erasure):_*)

    val obj: (A,B)=>R = cons.newInstance(staticData.map(_._2.asInstanceOf[AnyRef]):_*).asInstanceOf[(A,B)=>R]
    obj
  }

  def compile3[A,B,C,R](f: (Exp[A], Exp[B], Exp[C]) => Exp[R])(implicit mA: Manifest[A], mB: Manifest[B], mC: Manifest[C], mR: Manifest[R]): (A,B,C)=>R = {
    if (this.compiler eq null)
      setupCompiler()

    val className = "staged$" + compileCount
    compileCount += 1

    val source = new StringWriter()
    val staticData = codegen.emitSource3(f, className, new PrintWriter(source))

    if (dumpGeneratedCode) println(source)

    val compiler = this.compiler
    val run = new compiler.Run

    val fileSystem = new VirtualDirectory("<vfs>", None)
    compiler.settings.outputDirs.setSingleOutput(fileSystem)
  //      compiler.genJVM.outputDir = fileSystem

    run.compileSources(List(new util.BatchSourceFile("<stdin>", source.toString)))
    reporter.printSummary()

    if (!reporter.hasErrors)
      println("compilation: ok")
    else
      println("compilation: had errors")

    reporter.reset
    //output.reset

    val parent = this.getClass.getClassLoader
    val loader = new AbstractFileClassLoader(fileSystem, this.getClass.getClassLoader)

    val cls: Class[_] = loader.loadClass(className)
    val cons = cls.getConstructor(staticData.map(_._1.tp.erasure):_*)

    val obj: (A,B,C)=>R = cons.newInstance(staticData.map(_._2.asInstanceOf[AnyRef]):_*).asInstanceOf[(A,B,C)=>R]
    obj
  }
}