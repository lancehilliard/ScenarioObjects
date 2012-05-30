using ArbitraryValues;
using ArbitraryValues.FakeMakers;
using Machine.Specifications;
using Rhino.Mocks;

namespace $rootnamespace$ {
    public class ScenarioObjects {
        Establish c = () => {
            AssignFakes();
            AssignDeliberates();
            AssignArbitraryValues();
            AssignSystemsUnderTest();
        };

        /// <summary>
        /// Assigns a RhinoMocks-generated Mock to all of ScenarioObject's protected field variables ending in "Fake".
        /// </summary>
        static void AssignFakes() {
            Foo.AssignFakes<ScenarioObjects>(FakeMaker<MockRepository>.Make);
        }

        /// <summary>
        /// Use this method to assign values that are relevant to the specs which use them. Use these objects when the spec relies upon the variable's value.
        /// </summary>
        /// <example>
        /// NegativeDecimalDeliberate = (decimal)-42.53; // not arbitrary; spec expects value to be negative
        /// RedColorDeliberate = Color.Red; // not arbitrary; spec expects value to be Red
        /// PrimeNumberIntegerDeliberate = 7; // not deliberate; specs expects value to be prime 
        /// </example>
        static void AssignDeliberates() {
            
        }

        /// <summary>
        /// Assigns an arbitrary value to all of ScenarioObject's protected field value-type variables ending in "Value". Use these objects when the spec relies upon the name of the variable for readability and doesn't care what its value is.
        /// </summary>
        static void AssignArbitraryValues() {
            Foo.AssignArbitraryValues<ScenarioObjects>();
        }

        /// <summary>
        /// Use this method to instantiate and assign your System Under Test (SUT) variables, injecting Fakes for dependencies as necessary.
        /// </summary>
        static void AssignSystemsUnderTest() {

        }

    }

    public class ScenarioObjects<T> : ScenarioObjects {
        protected T Result;
    }
}
