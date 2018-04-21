
package visitor;
import syntaxtree.*;
import symboltable.*;
import java.util.Enumeration;


public class CodeGenerator extends DepthFirstVisitor {

    private java.io.PrintStream out;
    private static int nextLabelNum = 0;
    private Table symTable;  
    
    private StringBuilder dataString = new StringBuilder("");
    private RamClass currentClass;
    private RamMethod currentMethod;
    
    private int nextLabel() {
        return nextLabelNum++;
        
    }
    
    public CodeGenerator(java.io.PrintStream o, Table st) {
        out = o; 
        symTable = st;
        initDataString();
    }
    
    private void initDataString() {
        dataString = new StringBuilder();
        dataString.append("newline: .asciiz \"\\n\"\n");
        dataString.append("space: .asciiz \" \"\n");
    }

    private void emit(String s) {
        out.println("\t" + s);
    }

    private void emitLabel(String l) {
        out.println(l + ":");
    }
    
    private void emitLabel(String l, String comment) {
        out.printf("%-40s\t%s\n", l + ":", "# " + comment);
    }
    
    private void emitComment(String s) {
        out.println("\t" + "#" + s);
    }
    
    // MainClass m;
    // ClassDeclList cl;
    public void visit(Program n) {
        
        emit(".text");
        emit(".globl main");
        
        n.m.accept(this);
        for ( int i = 0; i < n.cl.size(); i++ ) {
            n.cl.elementAt(i).accept(this);
        }
        
        emit("");
        emit(".data");
        out.println(dataString.toString());
    }
    
    // Identifier i1, i2;
    // Statement s;
    public void visit(MainClass n) {
        symTable.addClass(n.i1.toString());
        TypeCheckVisitor.currClass = symTable.getClass(n.i1.toString());
        symTable.getClass(n.i1.s).addMethod("main", new IdentifierType("void"));
        TypeCheckVisitor.currMethod = symTable.getClass(n.i1.toString()).getMethod("main");
        symTable.getMethod("main", 
                TypeCheckVisitor.currClass.getId()).addParam(n.i2.toString(), new IdentifierType("String[]"));

        emitLabel("main");
        
        emitComment("begin prologue -- main");
        emit("subu $sp, $sp, 24    # stack frame is at least 24 bytes");
        emit("sw $fp, 4($sp)       # save caller's frame pointer");
        emit("sw $ra, 0($sp)       # save return address");
        
        emit("addi $fp, $sp, 20    # set up main's frame pointer");       
        emitComment("end prologue -- main");
        
        n.s.accept(this);
        
        emitComment("begin epilogue -- main");
        emit("lw $ra, 0($sp)       # restore return address");
        emit("lw $fp, 4($sp)       # restore caller's frame pointer");
        emit("addi $sp, $sp, 24    # pop the stack"); 
        emitComment("end epilogue -- main");
        
        /*
        emit("jr $ra");   // SPIM: how to end programs
        emit("\n");       // SPIM: how to end programs 
        */
        
        emit("li $v0, 10");   // MARS: how to end programs
        emit("syscall");      // MARS: how to end programs
        
        TypeCheckVisitor.currMethod = null;
        
    }
    
    // TODO
    // Exp e;
    public void visit(Print n) {
        emitComment("begin Print");

        n.e.accept(this);

        emit("move $a0, $v0");
        emit("li $v0, 1");
        emit("syscall");
            
        emitComment("end Print");

    }
    
    public void visit(Println n) {
        emitComment("begin Println");
        
        n.e.accept(this);

        emit("move $a0, $v0");
        emit("li $v0, 1");
        emit("syscall");

        emit("la $a0, newline");
        emit("li $v0, 4");
        emit("syscall");

        emitComment("end Println");
       
    }
    // int i;
    public void visit(IntegerLiteral n) {
        emit("li $v0, "+n.i+"        # load literal "+n.i+" into $v0");
    }    
    
    public void visit(Plus n) {
        emitComment("begin Plus");
        n.e1.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1, 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("add $v0, $t1, $v0");

        emitComment("end Plus");
    }

    public void visit(Minus n) {
        emitComment("begin Minus");

        n.e1.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("sub $v0, $t1, $v0");

        emitComment("end Minus");
    }

    public void visit(Times n) {
        emitComment("begin Times");

        n.e1.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("mul $v0, $t1, $v0");

        emitComment("end Times");
    }
    
    public void visit(True n) {
        emit("li $v0, 1");
    }

    public void visit(False n) {
        emit("li $v0, 0");
    }
    
    public void visit(If n) {
        int label = nextLabel();

        n.e.accept(this);

        emit(String.format("beqz $v0, ifFalse%d", label));

        n.s1.accept(this);

        emit("j isDone" + label);
        emitLabel("ifFalse" + label);

        n.s2.accept(this);

        emitLabel("isDone" + label);
    }

    public void visit(And n) {
        emitComment("start And");

        n.e1.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("and $v0, $t1, $v0");

        emitComment("end And");
    }

    public void visit(Or n) {
        emitComment("start Or");

        n.e1.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("or $v0, $t1, $v0");

        emitComment("end Or");
    }

    public void visit(LessThan n) {
        emitComment("start LessThan");

        n.e1.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("slt $v0, $t1, $v0");

        emitComment("end LessThan");
    }
    
    public void visit(LessThanOrEqualTo n) {
        emitComment("start LessThanOrEqualTo");

        n.e1.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("ble $v0, $t1, $v0");

        emitComment("end LessThanOrEqualTo");
    }
    
     public void visit(GreaterThan n) {
        emitComment("start GreaterThan");

        n.e1.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("bgt $v0, $t1, $v0");

        emitComment("end GreaterThan");
    }
     
      public void visit(GreaterThanOrEqualTo n) {
        emitComment("start GreaterThanOrEqualTo");

        n.e1.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("bge $v0, $t1, $v0");

        emitComment("end GreaterThanOrEqualTo");
    }

    public void visit(Equals n) {
        emitComment("start Equals");

        n.e1.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("seq $v0, $t1, $v0");

        emitComment("end Equals");
    }

    public void visit(Not n) {
        emitComment("start Not");

        n.e.accept(this);

        emit("xori $v0, $v0, 1");

        emitComment("end Not");
    }
    
     public void visit(Call n) {
        emitComment("start Call");

        for (int i = n.el.size() - 1; i >= 0; i--) {
            n.el.elementAt(i).accept(this);

            emit("subu $sp, $sp, 4");
            emit("sw $v0 0($sp)");
        }

        emit("jal " + n.i.s);
        emit("addi $sp, $sp, 4");

        emitComment("end Call");
    }
     
    public void visit(MethodDecl n) {
        currentMethod = currentClass.getMethod(n.i.s);

        emitLabel(n.i.s);

        emit("subu $sp, $sp, 16");
        emit("sw $fp, 8($sp)");
        emit("sw $ra, 0($sp)");
        emit("addu $fp, $sp, 12");

        super.visit(n);

        emit("lw $ra, -12($fp)");
        emit("lw $fp, -4($fp)");
        emit("addi $sp, $sp, 16");
        emit("jr $ra");

        currentMethod = null;
    }
    
    public void visit(ClassDeclSimple n) {
        currentClass = symTable.getClass(n.i.s);
        currentMethod = null;

        super.visit(n);

        currentClass = null;
    }
    
    public void visit(Identifier n) {
        RamVariable variable;

        emitComment("start Indentifier"); 
        
        if (currentMethod == null) {
            variable = currentClass.getVar(n.s);
        } else {
            variable = currentMethod.getVar(n.s);

            if (variable == null) {
                variable = currentMethod.getParam(n.s);
            }
        }

        if (variable != null) {
            emit("addi $v0, $fp, " + variable.getOffset());
        }
        
        emitComment("end Indentifier");
    }
     
    public void visit(IdentifierExp n) {
        RamVariable variable;

        if (currentMethod == null) {
            variable = currentClass.getVar(n.s);
        } 
        else {
            variable = currentMethod.getVar(n.s);

            if (variable == null) {
                variable = currentMethod.getParam(n.s);
            }
        }
        
        if (variable != null) {
            emit("addi $v0, $fp, " + variable.getOffset());
            emit("lw $v0, ($v0)");
        }
    }
    
     public void visit(Assign n) {
        n.e.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.i.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("sw $t1, $v0");
    }
     
     public void visit(While n)
     {
         /*n.e.accept(this);

        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");

        n.e2.accept(this);

        emit("lw $t1 0($sp)");
        emit("addu $sp, $sp, 4");

        emit("slt $v0, $t1, $v0");*/
        
        int label = nextLabel();
        

        n.e.accept(this);
        
        emit("subu $sp, $sp, 4");
        emit("sw $v0 0($sp)");
        
        emit(String.format("beqz $v0, ifFalse%d", label));

        n.s.accept(this);

        emitLabel("jr $v0" + label);
        
        emitLabel("ifFalse" + label);
        emitLabel("isDone" + label);

         
         
     }




}
