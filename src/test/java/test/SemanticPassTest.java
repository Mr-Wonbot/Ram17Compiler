package test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import static org.junit.Assert.fail;
import static org.junit.Assert.assertTrue;
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
public class SemanticPassTest {

    @Parameter
    public String filePath;

    @Parameters(name = "{index}: testFile - {0}")
    public static Object[] data() {
        return new Object[] {
            System.getProperty("TEST_PROGRAMS_DIR")+"/pass/Bool.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/pass/HelloWorld.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/pass/InfiniteLoop.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/pass/LinearSearch.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/pass/Logical.ram17",
            System.getProperty("TEST_PROGRAMS_DIR")+"/pass/Program2.ram17"
        };
    }


    @Test
    public void runPassTests() {
        try {
            String args[] = {filePath};
            driver.Ram17Compiler.main(args);
        } catch (Exception e) {
            fail(e.toString());
        }
    }


}
