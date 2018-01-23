package applications.tests;

import static applications.tests.FixtureDefinitions.CODEGENERATION_INPUT_FILENAME;
import static applications.tests.FixtureDefinitions.CODEGENERATION_EXPECTED_FILENAME;

import java.io.FileNotFoundException;
import java.io.PrintStream;

import applications.PikaCodeGenerator;
import applications.PikaCompiler;
import parseTree.ParseTreePrinter.Level;

import tests.FileFixturesTestCase;
import tests.FileFixturesTestCase.Command;
import tokens.Tokens;

public class TestCodeGenerator extends FileFixturesTestCase {
	public void testCodeGeneration() throws Exception {
		CodeGenerationSingleTest(Level.FULL, Tokens.Level.FULL, CODEGENERATION_INPUT_FILENAME);
	}
	
	public void CodeGenerationSingleTest(Level level, Tokens.Level tokenLevel, String string) throws Exception {
		String actualOutput =	codeGenerationOutput(CODEGENERATION_INPUT_FILENAME);
//		String expectedOutput = getContents(CODEGENERATION_EXPECTED_FILENAME);
//		System.out.println("actual Output");
		System.out.println(actualOutput);
//		assertEquals(expectedOutput, actualOutput);
	}
	
	private String codeGenerationOutput(String filename) throws Exception {
		return outputFor(new CodeGenerationCommand(filename));
	}
	
	public class CodeGenerationCommand implements Command {
		String filename;
		public CodeGenerationCommand(String filename) {
			this.filename = filename;
		}

		public void run(PrintStream out) throws FileNotFoundException {
			PikaCompiler.compile(filename);
		}
	}
	
}
