using ArbitraryValues;
using ArbitraryValues.FakeMakers;
using Machine.Specifications;
using Rhino.Mocks;

namespace ScenarioObjects {
    public class ScenarioObjects {
        Establish c = () => {
            AssignFakes();
            AssignDeliberates();
            AssignArbitraryValues();
            AssignSystemsUnderTest();
        };

        /// <summary>
        /// Assigns all of ScenarioObject's protected field variables ending in "Fake" a RhinoMocks-generated Mock.
        /// </summary>
        static void AssignFakes() {
            Foo.AssignFakes<ScenarioObjects>(FakeMaker<MockRepository>.Make);
        }

        /// <summary>
        /// Use this method to assign values that are relevant to the specs which use them. You should consider these values when writing your specs.
        /// </summary>
        static void AssignDeliberates() {
            
        }

        /// <summary>
        /// Assigns all of ScenarioObject's protected field value-type variables ending in "Value" an arbitrary value. You won't know these values when you write your specs.
        /// </summary>
        static void AssignArbitraryValues() {
            Foo.AssignArbitraryValues<ScenarioObjects>();
        }

        /// <summary>
        /// Use this method to instantiate and assign your SUT variables, injecting Fakes for dependencies.
        /// </summary>
        static void AssignSystemsUnderTest() {

        }

    }

    public class ScenarioObjects<T> : ScenarioObjects {
        protected T Result;
    }
}
