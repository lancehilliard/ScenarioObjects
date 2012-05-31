ScenarioObjects
===============

You can install ScenarioObjects using [NuGet](http://nuget.org/packages/ScenarioObjects):

<pre>
  PM> Install-Package ScenarioObjects
</pre>

# What is it?

ScenarioObjects is a parent class for your [Machine.Specifications](https://github.com/machine/machine.specifications) scenario classes. It gives you a single place, above those classes, to define and assign the objects that all of those classes will share. Its use results in cleaner spec classes that you write in less time.

# Getting Started with ScenarioObjects

Once ScenarioObjects is installed, you'll find ScenarioObjects.cs in the root of your project. It will contain four methods:

<pre>
  AssignFakes();
  AssignDeliberates();
  AssignArbitraryValues();
  AssignSystemsUnderTest();
</pre>

Documentation appears above each method.

ScenarioObjects is where you define field variables for each object your scenario classes will use as you compose your specifications/tests. As more and more specs regard the same scenario objects, you'll save more and more time writing tests, as you discover that the objects you need to compose the specifications are already defined and assigned in ScenarioObjects.

## Without ScenarioObjects

Without ScenarioObjects, you create all of your fields in your scenario class.

    [Subject("Appliance Designer Adds Widget to Appliance")]
    public class when_user_provides_minimum_required_widget_information {
        Establish context = () => {
            WidgetCreateViewFake = MockRepository.GenerateMock<IWidgetCreateView>();
            ApplianceRepositoryFake = MockRepository.GenerateMock<IApplianceRepository>();
            WidgetFactoryFake = MockRepository.GenerateMock<IWidgetFactory>();
            WidgetRepositoryFake = MockRepository.GenerateMock<IWidgetRepository>();

            ApplianceIdValue = 42;
            ApplianceValue = new Appliance(null, null);
            WidgetCreateEventArgsValue = new WidgetCreateEventArgs(null, null, null, null, 0, null);
            WidgetValue = new Widget(null);

            WidgetCreateViewFake.Stub(x => x.ApplianceId).Return(ApplianceIdValue);
            ApplianceRepositoryFake.Stub(x => x.FindById(ApplianceIdValue)).Return(ApplianceValue);
            WidgetFactoryFake.Stub(x => x.Create(WidgetCreateEventArgsValue)).Return(WidgetValue);
            new WidgetCreatePresenter(WidgetCreateViewFake, ApplianceRepositoryFake, WidgetFactoryFake, WidgetRepositoryFake);
        };

        Because action = () => WidgetCreateViewFake.Raise(x => x.WidgetCreateRequested += null, null, WidgetCreateEventArgsValue);

        It should_add_the_widget = () => WidgetRepositoryFake.AssertWasCalled(x => x.Store(WidgetValue));

        It should_show_the_updated_appliance = () => WidgetCreateViewFake.AssertWasCalled(x => x.Appliance = ApplianceValue);

        static IWidgetCreateView WidgetCreateViewFake;
        static int ApplianceIdValue;
        static IApplianceRepository ApplianceRepositoryFake;
        static IAppliance ApplianceValue;
        static IWidgetFactory WidgetFactoryFake;
        static WidgetCreateEventArgs WidgetCreateEventArgsValue;
        static IWidget WidgetValue;
        static IWidgetRepository WidgetRepositoryFake;
    }

## With ScenarioObjects

As you start to use ScenarioObjects, your scenario classes get much smaller and easier to read. Every scenario class is another opportunity to re-use a field from ScenarioObjects.

    [Subject("Appliance Designer Adds Widget to Appliance")]
    public class when_user_provides_minimum_required_widget_information : ScenarioObjects {
        Establish context = () => {
            WidgetCreateViewFake.Stub(x => x.ApplianceId).Return(ApplianceIdValue);
            ApplianceRepositoryFake.Stub(x => x.FindById(ApplianceIdValue)).Return(ApplianceValue);
            WidgetFactoryFake.Stub(x => x.Create(WidgetCreateEventArgsValue)).Return(WidgetValue);
            new WidgetCreatePresenter(WidgetCreateViewFake, ApplianceRepositoryFake, WidgetFactoryFake, WidgetRepositoryFake);
        };

        Because action = () => WidgetCreateViewFake.Raise(x => x.WidgetCreateRequested += null, null, WidgetCreateEventArgsValue);

        It should_add_the_widget = () => WidgetRepositoryFake.AssertWasCalled(x => x.Store(WidgetValue));

        It should_show_the_updated_appliance = () => WidgetCreateViewFake.AssertWasCalled(x => x.Appliance = ApplianceValue);
    }


    public class ScenarioObjects {
        Establish c = () => {
            AssignFakes();
            AssignDeliberates();
            AssignArbitraryValues();
            AssignSystemsUnderTest();
        };

        static void AssignFakes() {
            Foo.AssignFakes<ScenarioObjects>(FakeMaker<MockRepository>.Make);
        }

        static void AssignDeliberates() {}

        static void AssignArbitraryValues() {
            Foo.AssignArbitraryValues<ScenarioObjects>();
        }

        static void AssignSystemsUnderTest() {}

        protected static IWidgetCreateView WidgetCreateViewFake;
        protected static int ApplianceIdValue;
        protected static IApplianceRepository ApplianceRepositoryFake;
        protected static IAppliance ApplianceValue;
        protected static IWidgetFactory WidgetFactoryFake;
        protected static WidgetCreateEventArgs WidgetCreateEventArgsValue;
        protected static IWidget WidgetValue;
        protected static IWidgetRepository WidgetRepositoryFake;
    }
