package toolbox
/*
import scala.tools.nsc.reporters._
import scala.tools.nsc.CompilerCommand
import scala.tools.nsc.Global
import scala.tools.nsc.Settings
import scala.tools.nsc.io.VirtualDirectory
import scala.tools.nsc.interpreter.AbstractFileClassLoader
import scala.tools.reflect.ReflectGlobal
import scala.reflect.internal.util.NoSourceFile
import java.lang.{Class => jClass}
*/

// From scala.tools.reflect.ToolBoxFactory (compiler)
// http://stackoverflow.com/questions/11055210/whats-the-easiest-way-to-use-reify-get-an-ast-of-an-expression-in-scala
/*
ClassDef(Modifiers(), newTypeName("Y"), List(),
  Template(
    List(Ident(newTypeName("AnyRef"))),
    emptyValDef,
    List(
      DefDef(Modifiers(), nme.CONSTRUCTOR, List(), List(List()), TypeTree(),
        Block(List(Apply(Select(Super(This(tpnme.EMPTY), tpnme.EMPTY), nme.CONSTRUCTOR), List())), Literal(Constant(())))
      ),
      DefDef(Modifiers(), newTermName("f"), List(), List(List(ValDef(Modifiers(PARAM), newTermName("x"), Ident(scala.Int), EmptyTree))), Ident(scala.Int),
        Apply(Select(Ident(newTermName("x")), newTermName("$plus")), List(Select(This(newTypeName("ToolBoxApp")), newTermName("k"))))
      )
    )
  )
)

ClassDef(Modifiers(), newTypeName("Y"), List(),
  Template(
    List(Ident(toolbox.Signature)), <<----------- MIND HERE THE TYPE
    emptyValDef,
    List(
      DefDef(Modifiers(), nme.CONSTRUCTOR, List(), List(List()), TypeTree(),
        Block(List(Apply(Select(Super(This(tpnme.EMPTY), tpnme.EMPTY), nme.CONSTRUCTOR), List())), Literal(Constant(())))
    ),
    DefDef(Modifiers(), newTermName("f"), List(), List(List(ValDef(Modifiers(PARAM), newTermName("x"), Ident(scala.Int), EmptyTree))), Ident(scala.Int),
      Apply(Select(Ident(newTermName("x")), newTermName("$plus")), List(Select(This(newTypeName("ToolBoxApp")), newTermName("k"))))))
    )
  )
)
*/

/*
class MyToolBox {
  class ToolBoxGlobal(settings: Settings, reporter: Reporter) extends ReflectGlobal(settings, reporter, classLoader) {
      import definitions._

      private var wrapCount = 0
      private def nextWrapperModuleName() = {
        wrapCount += 1
        newTermName("__wrapper$" + wrapCount + "$" + java.util.UUID.randomUUID.toString.replace("-", ""))
      }

      def verify(expr: Tree): Unit = {
        val typed = expr filter (t => t.tpe != null && t.tpe != NoType && !t.isInstanceOf[TypeTree])
        if (!typed.isEmpty) sys.error("reflective toolbox has failed: cannot operate on trees that are already typed")

        val freeTypes = expr.freeTypes
        if (freeTypes.length > 0) {
          var msg = "reflective toolbox has failed:\n"
          msg += "unresolved free type variables (namely: " + (freeTypes map (ft => "%s %s".format(ft.name, ft.origin)) mkString ", ") + "). "
          msg += "have you forgot to use TypeTag annotations for type parameters external to a reifee? "
          msg += "if you have troubles tracking free type variables, consider using -Xlog-free-types"
          sys.error(msg)
        }
      }

      def extractFreeTerms(expr0: Tree, wrapFreeTermRefs: Boolean): (Tree, scala.collection.mutable.LinkedHashMap[FreeTermSymbol, TermName]) = {
        val freeTerms = expr0.freeTerms
        val freeTermNames = scala.collection.mutable.LinkedHashMap[FreeTermSymbol, TermName]()
        freeTerms foreach (ft => {
          var name = ft.name.toString
          val namesakes = freeTerms takeWhile (_ != ft) filter (ft2 => ft != ft2 && ft.name == ft2.name)
          if (namesakes.length > 0) name += ("$" + (namesakes.length + 1))
          freeTermNames += (ft -> newTermName(name + nme.REIFY_FREE_VALUE_SUFFIX))
        })
        var expr = new Transformer {
          override def transform(tree: Tree): Tree =
            if (tree.hasSymbol && tree.symbol.isFreeTerm) {
              tree match {
                case Ident(_) =>
                  val freeTermRef = Ident(freeTermNames(tree.symbol.asFreeTerm))
                  if (wrapFreeTermRefs) Apply(freeTermRef, List()) else freeTermRef
                case _ => sys.error("internal error: %s (%s, %s) is not supported".format(tree, tree.productPrefix, tree.getClass))
              }
            } else {
              super.transform(tree)
            }
        }.transform(expr0)
        (expr, freeTermNames)
      }

      def compile(expr0: Tree): () => Any = {
        val expr1 = if (!expr0.isTerm) Block(List(expr0), Literal(Constant(()))) else expr0
        val thunks = expr1.freeTerms map (fte => () => fte.value)
        verify(expr1)


            // XXX: how to get companion object
          // XXX: make it inherit from Signature
            val parent = Ident(toolbox.Signature.toString)



        //def wrap(expr0: Tree): ModuleDef = {
          val (expr, freeTerms) = extractFreeTerms(expr1, wrapFreeTermRefs = true)
          val (obj, mclazz) = rootMirror.EmptyPackageClass.newModuleAndClassSymbol(nextWrapperModuleName())

          val minfo = ClassInfoType(List(ObjectClass.tpe), newScope, obj.moduleClass)
          obj.moduleClass setInfo minfo
          obj setInfo obj.moduleClass.tpe

          val funs:List[DefDef] = expr match {
            case Block(stats, expr) => stats.filter{case d:DefDef => true case _ => false }.asInstanceOf[List[DefDef]]
            case d:DefDef => List(d)
            case _ => Nil
          }

          val wrapperMethodName = "wrapper"
          val meth = obj.moduleClass.newMethod(newTermName(wrapperMethodName))
          def makeParam(schema: (FreeTermSymbol, TermName)) = {
            val (fv, name) = schema
            meth.newValueParameter(name) setInfo appliedType(definitions.FunctionClass(0).tpe, List(fv.tpe.resultType))
          }
          meth setInfo MethodType(freeTerms.map(makeParam).toList, AnyClass.tpe)
          minfo.decls enter meth
          def defOwner(tree: Tree): Symbol = tree find (_.isDef) map (_.symbol) match {
            case Some(sym) if sym != null && sym != NoSymbol => sym.owner
            case _ => NoSymbol
          }

          val methdef = DefDef(meth, This(tpnme.EMPTY)) // expr changeOwner (defOwner(expr) -> meth)
          val moduledef = ModuleDef(obj, Template(
                  List(TypeTree(ObjectClass.tpe)),
                  emptyValDef, NoMods, List(), List(List()),
                  List(methdef):::funs, NoPosition))

          var cleanedUp = resetLocalAttrs(moduledef)



        //}

        println("--------------------------------")
        println(u show expr0)
        println("--------------------------------")
        println(u show expr1)
        println("--------------------------------")

        val mdef = cleanedUp.asInstanceOf[ModuleDef]

        println(u show mdef)
        println("--------------------------------")


        val pdef = PackageDef(Ident(mdef.name), List(mdef))
        val unit = new CompilationUnit(NoSourceFile)
        unit.body = pdef

        val run = new Run
        reporter.reset()
        run.compileUnits(List(unit), run.namerPhase)

        val className = mdef.symbol.fullName
        if (settings.debug.value) println("generated: "+className)
        val jclazz = jClass.forName(className + "$", true, classLoader)
        val jmeth = jclazz.getDeclaredMethods.find(_.getName == wrapperMethodName).get
        val jfield = jclazz.getDeclaredFields.find(_.getName == "MODULE$").get
        val singleton = jfield.get(null)

        () => {
          val result = jmeth.invoke(singleton, thunks map (_.asInstanceOf[AnyRef]): _*)
          if (jmeth.getReturnType == java.lang.Void.TYPE) ()
          else result
        }
      }
  }

  val u = mirror.universe
  lazy val mirror = scala.reflect.runtime.currentMirror
  lazy val virtualDirectory = new VirtualDirectory("(memory)", None)
  lazy val classLoader = new AbstractFileClassLoader(virtualDirectory, mirror.classLoader)
  lazy val importer = compiler.mkImporter(u)
  lazy val compiler: ToolBoxGlobal = try {
    val command = new CompilerCommand(List(), msg => sys.error(msg)) // compiler arguments
    command.settings.outputDirs setSingleOutput virtualDirectory
    new ToolBoxGlobal(command.settings, new ConsoleReporter(command.settings))
  } catch {
    case ex: Throwable => sys.error("reflective compilation has failed: cannot initialize the compiler due to %s".format(ex.toString))
  }
  def compile(tree: u.Tree): () => Any = compiler.compile(importer.importTree(tree))
}

trait Signature {
  def f(x:Int):Int
//  def g(x:Int):Int
}
object Signature {} // XXX: extends ?
*/
object ToolBoxApp extends App {
  import scala.reflect.runtime.{universe => u}
  //import scala.reflect.runtime.universe._


/*
  println(u.typeOf[Signature].toString) // This is exactely the class we want to extend


  val y = u.reify {
    class Y extends Signature {
      def f(x:Int):Int = x+k
      def foo:Y = this
    }
  }
  println(u showRaw y);
  println(u show y);


  val c=new MyToolBox()
  val k = 3
  val x = u.reify {
    def f(x:Int):Int = x+k
    def g(x:Int):Int = x*k
    this
  }
  println(u showRaw x);

  val w = c.compile(x.tree)()

  println(w)
*/

  val ff:u.Expr[Function1[Int,Int]] = u.reify {
    //def f(x:Int):Int = x*2
    (x:Int) => x*2
  }

  // scala.reflect.api.Exprs$ExprImpl

  println(ff.getClass)

  println(u showRaw ff)

  import scala.tools.reflect.Eval
  def g = ff.eval

  println(g)
  println(g(3))






}
