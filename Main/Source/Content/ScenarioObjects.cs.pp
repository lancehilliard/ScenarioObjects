using ArbitraryValues;
using ArbitraryValues.FakeMakers;
using Machine.Specifications;
using Rhino.Mocks;

namespace $rootnamespace$ {
    /// <summary>
    /// All of your spec classes should extend ScenarioObjects. Defining and
    /// assigning fields here (instead of in your spec classes) reduces the
    /// noise in each spec class, encourages re-use of objects between your
    /// scenario classes, and makes it easier to quickly focus on your
    /// spec's essense when authoring tests.
    /// </summary>
    /// <remarks>
    /// This file will normally get quite large as your test suite grows in
    /// size. The objects maintained in this class become an ever-growing
    /// vocabulary for your test suite's stories (a pseudo-DSL, if you will).
    /// 
    /// Re-use of these objects allows you to quickly articulate what
    /// you're specifying via the prose of your specs. Feel free to create
    /// fields very similar in name if it improves the readability of your
    /// specs.
    /// </remarks>
    /// <see href="https://github.com/lancehilliard/ScenarioObjects">Learn More</see>
    public class ScenarioObjects {
        /// <summary>
        /// This context will run before the context specified in each of 
        /// your spec classes, repeating for each test the setup of fakes,
        /// deliberate and arbitrary values, and SUTs.
        /// </summary>
        Establish c = () => {
            AssignFakes();
            AssignDeliberates();
            AssignArbitraryValues();
            AssignSystemsUnderTest();
        };

        /// <summary>
        /// Assigns a RhinoMocks-generated Mock to all of ScenarioObject's
        /// protected field variables ending in "Fake".
        /// </summary>
        static void AssignFakes() {
            Foo.AssignFakes<ScenarioObjects>(FakeMaker<MockRepository>.Make);
        }

        /// <summary>
        /// Use this method to assign values that are relevant to the specs
        /// which use them. Use these objects when the spec relies upon the
        /// variable's value.
        /// </summary>
        /// <example>
        /// NegativeDecimalDeliberate = (decimal)-42.53; // not arbitrary; spec expects value to be negative
        /// RedColorDeliberate = Color.Red; // not arbitrary; spec expects value to be Red
        /// PrimeNumberIntegerDeliberate = 7; // not deliberate; specs expects value to be prime 
        /// </example>
        static void AssignDeliberates() {
            
        }

        /// <summary>
        /// Assigns an arbitrary value to all of ScenarioObject's protected
        /// field value-type variables ending in "Value". Use these objects
        /// when the spec relies upon the name of the variable for
        /// readability and doesn't care what its value is.
        /// </summary>
        static void AssignArbitraryValues() {
            Foo.AssignArbitraryValues<ScenarioObjects>();
        }

        /// <summary>
        /// Use this method to instantiate and assign your
        /// System Under Test (SUT) variables, injecting Fakes for
        /// dependencies as necessary.
        /// </summary>
        static void AssignSystemsUnderTest() {

        }
    }

    /// <summary>
    /// Have your spec class extend this class if you need to assert against
    /// the results of your SUT.
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class ScenarioObjects<T> : ScenarioObjects {
        static protected T Result;
    }
}
