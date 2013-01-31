package  fr.irisa.cairn.gecos.bindings.mathematica;
import fr.irisa.cairn.model.mathematica.BuiltInNode;
import fr.irisa.cairn.model.mathematica.IntLeaf;
import fr.irisa.cairn.model.mathematica.Node;

public class TomPatternMatchingExample{

	private static boolean tom_equal_term_int(int t1, int t2) {return  t1==t2 ;}private static boolean tom_is_sort_int(int t) {return  true ;} private static boolean tom_equal_term_float(float t1, float t2) {return  t1==t2 ;}private static boolean tom_is_sort_float(float t) {return  true ;} private static boolean tom_equal_term_double(double t1, double t2) {return  t1==t2 ;}private static boolean tom_is_sort_double(double t) {return  true ;} private static boolean tom_equal_term_char(char t1, char t2) {return  t1==t2 ;}private static boolean tom_is_sort_char(char t) {return  true ;} private static boolean tom_equal_term_String(String t1, String t2) {return  t1.equals(t2) ;}private static boolean tom_is_sort_String(String t) {return  t instanceof String ;} private static boolean tom_equal_term_List(Object l1, Object l2) {return  l1.equals(l2) ;}private static boolean tom_is_sort_List(Object t) {return  t instanceof java.util.List ;} private static boolean tom_equal_term_Node(Object c1, Object c2) {return  c1.equals(c2) ;}private static boolean tom_is_sort_Node(Object c) {return  (c instanceof Node) ;}private static boolean tom_is_fun_sym_Set( Node  c) {return  isBuiltIn(c,"Set") ;}private static  Node  tom_make_Set( Node  s,  Node  c) { return  
    	fr.irisa.cairn.gecos.bindings.mathematica.TomFactory.makeBuiltInNode("Set",s,c)
    ;}private static  Node  tom_get_slot_Set_left( Node  c) {return  ((BuiltInNode)c).getChildren().get(0) ;}private static  Node  tom_get_slot_Set_right( Node  c) {return  ((BuiltInNode)c).getChildren().get(1) ;}private static boolean tom_is_fun_sym_Int( Node  c) {return  (c instanceof IntLeaf) ;}private static  Node  tom_make_Int( int  s) { return  
    	fr.irisa.cairn.gecos.bindings.mathematica.TomFactory.makeInt(s)
    ;}private static  int  tom_get_slot_Int_value( Node  c) {return  ((IntLeaf)c).getValue() ;}private static  Node  tom_make_Sym( String  s) { return  
    	fr.irisa.cairn.gecos.bindings.mathematica.TomFactory.makeSymbol(s)
    ;}private static boolean tom_is_fun_sym_List( Node  c) {return  isBuiltIn(c,"List") ;}private static  Node  tom_empty_array_List(int n) { return  fr.irisa.cairn.gecos.bindings.mathematica.TomFactory.makeBuiltInNode("List") ;}private static  Node  tom_cons_array_List( Node  e,  Node  l) { return  TomUtils.add(l,e) ;}private static  Node  tom_get_element_List_Node( Node  l, int n) {return  ((BuiltInNode) l).getChildren().get(n) ;}private static int tom_get_size_List_Node( Node  l) {return  ((BuiltInNode) l).getChildren().size() ;}   private static   Node  tom_get_slice_List( Node  subject, int begin, int end) {      Node  result = tom_empty_array_List(end-begin);     while(begin!=end) {       result = tom_cons_array_List(tom_get_element_List_Node(subject,begin),result);       begin++;     }     return result;   }    private static   Node  tom_append_array_List( Node  l2,  Node  l1) {     int size1 = tom_get_size_List_Node(l1);     int size2 = tom_get_size_List_Node(l2);     int index;      Node  result = tom_empty_array_List(size1+size2);     index=size1;     while(index >0) {       result = tom_cons_array_List(tom_get_element_List_Node(l1,size1-index),result);       index--;     }      index=size2;     while(index > 0) {       result = tom_cons_array_List(tom_get_element_List_Node(l2,size2-index),result);       index--;     }     return result;   }private static boolean tom_is_fun_sym_Module( Node  c) {return  isBuiltIn(c,"Module") ;}private static  Node  tom_empty_array_Module(int n) { return  fr.irisa.cairn.gecos.bindings.mathematica.TomFactory.makeBuiltInNode("Module") ;}private static  Node  tom_cons_array_Module( Node  e,  Node  l) { return  TomUtils.add(l,e) ;}private static  Node  tom_get_element_Module_Node( Node  l, int n) {return  ((BuiltInNode) l).getChildren().get(n) ;}private static int tom_get_size_Module_Node( Node  l) {return  ((BuiltInNode) l).getChildren().size() ;}   private static   Node  tom_get_slice_Module( Node  subject, int begin, int end) {      Node  result = tom_empty_array_Module(end-begin);     while(begin!=end) {       result = tom_cons_array_Module(tom_get_element_Module_Node(subject,begin),result);       begin++;     }     return result;   }    private static   Node  tom_append_array_Module( Node  l2,  Node  l1) {     int size1 = tom_get_size_Module_Node(l1);     int size2 = tom_get_size_Module_Node(l2);     int index;      Node  result = tom_empty_array_Module(size1+size2);     index=size1;     while(index >0) {       result = tom_cons_array_Module(tom_get_element_Module_Node(l1,size1-index),result);       index--;     }      index=size2;     while(index > 0) {       result = tom_cons_array_Module(tom_get_element_Module_Node(l2,size2-index),result);       index--;     }     return result;   }      
 
	public static boolean isBuiltIn(Node node, String type) {
		if (node instanceof BuiltInNode) {
	 		BuiltInNode bnode = (BuiltInNode ) node;
			if (bnode.getKeyword().equals(type)) return true;
		}
		return false; 
	}
 
	public static void main(String[] args) {
		 

	    Node c1 = tom_make_Set(tom_make_Int(4),tom_make_Int(2));
	    Node c2 = tom_cons_array_List(tom_make_Int(1),tom_cons_array_List(tom_make_Sym("pol"),tom_cons_array_List(tom_make_Int(6),tom_empty_array_List(3))));
	    Node c3 = tom_cons_array_Module(tom_make_Int(1),tom_cons_array_Module(tom_make_Int(6),tom_cons_array_Module(tom_make_Int(-1),tom_cons_array_Module(tom_make_Int(1),tom_empty_array_Module(4)))));
	  
	    {{if (tom_is_sort_Node(c1)) {if (tom_is_fun_sym_Set((( Node )c1))) { Node  tomMatch1NameNumber_freshVar_1=tom_get_slot_Set_left((( Node )c1)); Node  tomMatch1NameNumber_freshVar_2=tom_get_slot_Set_right((( Node )c1));if (tom_is_fun_sym_Int(tomMatch1NameNumber_freshVar_1)) { int  tom_a=tom_get_slot_Int_value(tomMatch1NameNumber_freshVar_1);if (tom_is_fun_sym_Int(tomMatch1NameNumber_freshVar_2)) { int  tom_b=tom_get_slot_Int_value(tomMatch1NameNumber_freshVar_2);
 
		        System.out.println("this operation computes " + 
		        		(tom_a)  +"+"+ (tom_b) +"="+(tom_make_Int(tom_a+tom_b))); 
		      }}}}}}{{if (tom_is_sort_Node(c2)) {if (tom_is_fun_sym_List((( Node )c2))) {int tomMatch2NameNumber_freshVar_2=0;if (!(tomMatch2NameNumber_freshVar_2 >= tom_get_size_List_Node((( Node )c2)))) {if (tom_is_fun_sym_Int(tom_get_element_List_Node((( Node )c2),tomMatch2NameNumber_freshVar_2))) {int tomMatch2NameNumber_end_6=tomMatch2NameNumber_freshVar_2 + 1;do {{if (!(tomMatch2NameNumber_end_6 >= tom_get_size_List_Node((( Node )c2)))) {if (tom_is_fun_sym_Int(tom_get_element_List_Node((( Node )c2),tomMatch2NameNumber_end_6))) {if (tomMatch2NameNumber_end_6 + 1 >= tom_get_size_List_Node((( Node )c2))) {


 
		        System.out.println("this List has two constant integer as elements"); 
		      }}}tomMatch2NameNumber_end_6=tomMatch2NameNumber_end_6 + 1;}} while(!(tomMatch2NameNumber_end_6 > tom_get_size_List_Node((( Node )c2))));}}}}}}{{if (tom_is_sort_Node(c3)) {if (tom_is_fun_sym_Module((( Node )c3))) {int tomMatch3NameNumber_freshVar_2=0;if (!(tomMatch3NameNumber_freshVar_2 >= tom_get_size_Module_Node((( Node )c3)))) {if (tom_is_fun_sym_Int(tom_get_element_Module_Node((( Node )c3),tomMatch3NameNumber_freshVar_2))) {int tomMatch3NameNumber_end_6=tomMatch3NameNumber_freshVar_2 + 1;do {{if (!(tomMatch3NameNumber_end_6 >= tom_get_size_Module_Node((( Node )c3)))) {if (tom_is_fun_sym_Int(tom_get_element_Module_Node((( Node )c3),tomMatch3NameNumber_end_6))) {if (tomMatch3NameNumber_end_6 + 1 >= tom_get_size_Module_Node((( Node )c3))) {


 
		        System.out.println("this Module node has at leats int constant operands"); 
		      }}}tomMatch3NameNumber_end_6=tomMatch3NameNumber_end_6 + 1;}} while(!(tomMatch3NameNumber_end_6 > tom_get_size_Module_Node((( Node )c3))));}}}}}}


	}
}