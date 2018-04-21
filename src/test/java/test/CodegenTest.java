package test;

import frontend.generated.ParseException;
import java.io.*;
import visitor.*;
import syntaxtree.Program;

import java.util.Scanner;
import static org.junit.Assert.assertEquals;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.junit.runners.Parameterized.Parameter;
import org.junit.runners.Parameterized.Parameters;


/**
 *
 * @author richardburns
 */
@RunWith(value = Parameterized.class)
public class CodegenTest {

    @Parameter
    public String filePath;

    @Parameters(name = "{index}: testFile - {0}")
    public static Object[] data() {
        return new Object[] {
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/Print.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/Println.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/Plus.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/IfTrue.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/IfFalse.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/And.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/LessThan.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/Not1.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/Not2.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/NewObject.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/MethodCall.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/Factorial0.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/Factorial1.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/Factorial10.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/1-required/While.ram17",

            System.getProperty("TEST_PROGRAMS_DIR")+"/2-extracredit/ClassLevel.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/2-extracredit/ArrayTest.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/2-extracredit/LinearSearch.ram17",

            System.getProperty("TEST_PROGRAMS_DIR")+"/3-other/SideEffectTest.ram17"
        };
    }

    @Test(timeout=5000)
    public void testRamProgram() throws FileNotFoundException, IOException, ParseException {
        
        String[] args = null;
        System.out.printf("Running javacc parser on %s ...\n", filePath.toString());
        args = new String[] { filePath.toString() };
                

        InputStream is = new FileInputStream(new File(args[0]));
        frontend.generated.RamParser parser = new frontend.generated.RamParser(is);
        syntaxtree.Program root = parser.Goal();
                    
        System.out.println("AST Created ...");

        // build symbol table
        BuildSymbolTableVisitor v = new BuildSymbolTableVisitor();  
        root.accept(v); 
        System.out.println("Symbol Table built ...");
                    
        System.out.println("Generating Assembly Code ...");

        // prepare to capture System.output
        PrintStream originalOut = System.out;
        OutputStream os = new ByteArrayOutputStream();
        PrintStream ps = new PrintStream(os);
        System.setOut(ps);
        try {
            root.accept(new visitor.CodeGenerator(System.out, v.getSymTab()));
        } finally {
            // restore normal System.output operation
            System.setOut(originalOut);            
        }

        System.out.println("Saving Assembly File ...");
        PrintWriter writer = new PrintWriter(filePath+".s");
        writer.print(os + System.getProperty("line.separator"));
        writer.close();
                    
        System.out.println("Running Assembly File in MIPS Simulator ...");
        Process p = Runtime.getRuntime().exec("java -jar " + System.getProperty("MARS_JAR") + " " + filePath+".s" + " " + "me");
        BufferedReader br1 = new BufferedReader(new InputStreamReader(p.getInputStream()));
        BufferedReader br2 = new BufferedReader(new InputStreamReader(p.getErrorStream()));

        System.out.println("Saving Assembly Output ...");
        writer = new PrintWriter(filePath+".s"+".output");
        String s;
        while ((s = br1.readLine()) != null)    // write stdout
        {
            writer.print(s + System.getProperty("line.separator"));
            System.out.println(s);
        }
        while ((s = br2.readLine()) != null)    // write stderr
        {
            // writer.print(s + System.getProperty("line.separator"));
            //System.err.println(s);
            System.err.print(s);
        }                    
        writer.close();

        System.out.println("Comparing Against Expected Output ...");
        // String s1 = org.apache.commons.io.FileUtils.readFileToString(new java.io.File(filePath+".correct"));
        // String s2 = org.apache.commons.io.FileUtils.readFileToString(new java.io.File(filePath+".py"+".output"));
        String s1 = new Scanner(new File(filePath+".correct")).useDelimiter("\\Z").next();
        String s2 = new Scanner(new File(filePath+".s"+".output")).useDelimiter("\\Z").next();
        s1 = s1.replaceAll("\\r\\n?", "\n");  // normalize line endings for Windows vs. Unix
        s2 = s2.replaceAll("\\r\\n?", "\n");
        assertEquals(s1, s2); 
    }

}
