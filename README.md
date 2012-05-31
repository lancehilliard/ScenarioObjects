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

Documentation appears in your editor above each method.

ScenarioObjects is where you define field variables for each object your scenario classes will use as you compose your entire suite of specifications/tests. As more and more specs regard the same business/domain concepts, you'll save more and more time writing tests, as you discover that the objects you need to compose the specifications are already defined and assigned, ready for use. ScenarioObjects begins to act as an ever-growing vocabulary for your spec classes.

## Without ScenarioObjects

Without ScenarioObjects, you create all of your fields in your scenario class. More than half of your context is assigning values to use in the scenario's tests and regards nothing about the behavior of the SUT. Add the lines defining those fields, and it's over half your class!

    [Subject("Appliance Designer Adds Widget to Appliance")]
    public class when_user_provides_minimum_required_widget_information {
        Establish context = () => {
            CreateViewFake = MockRepository.GenerateMock<IWidgetCreateView>();
            ApplianceRepoFake = MockRepository.GenerateMock<IApplianceRepository>();
            WidgetFactoryFake = MockRepository.GenerateMock<IWidgetFactory>();
            WidgetRepoFake = MockRepository.GenerateMock<IWidgetRepository>();

            ApplianceIdValue = 42;
            ApplianceValue = new Appliance(null, null);
            CreateEventArgsValue = new WidgetCreateEventArgs(null, null, null, null, 0, null);
            WidgetValue = new Widget(null);

            CreateViewFake.Stub(x => x.ApplianceId).Return(ApplianceIdValue);
            ApplianceRepoFake.Stub(x => x.FindById(ApplianceIdValue)).Return(ApplianceValue);
            WidgetFactoryFake.Stub(x => x.Create(CreateEventArgsValue)).Return(WidgetValue);
            new WidgetCreatePresenter(CreateViewFake, ApplianceRepoFake, WidgetFactoryFake, WidgetRepoFake);
        };

        Because of = () => {
            CreateViewFake.Raise(x => x.WidgetCreateRequested += null, null, CreateEventArgsValue);
        }

        It should_add_the_widget = () => {
            WidgetRepoFake.AssertWasCalled(x => x.Store(WidgetValue));
        }

        It should_show_the_updated_appliance = () => {
            CreateViewFake.AssertWasCalled(x => x.Appliance = ApplianceValue);
        }

        static IWidgetCreateView CreateViewFake;
        static int ApplianceIdValue;
        static IApplianceRepository ApplianceRepoFake;
        static IAppliance ApplianceValue;
        static IWidgetFactory WidgetFactoryFake;
        static WidgetCreateEventArgs CreateEventArgsValue;
        static IWidget WidgetValue;
        static IWidgetRepository WidgetRepoFake;
    }

This noise is repeated in every scenario class. You can clean things up a bit with parent classes per context or story (or epic), but the fields in *those* parent classes start to duplicate themselves before long, and you can find yourself in inheritance soup in no time.

## With ScenarioObjects

As you start to use ScenarioObjects, your scenario classes get much smaller and easier to read. The class below is ~70% smaller than the class above, and it does a better job of communicating the behavior that the spec is designed to protect.

    [Subject("Appliance Designer Adds Widget to Appliance")]
    public class when_user_provides_minimum_required_widget_information : ScenarioObjects {
        Establish context = () => {
            CreateViewFake.Stub(x => x.ApplianceId).Return(ApplianceIdValue);
            ApplianceRepoFake.Stub(x => x.FindById(ApplianceIdValue)).Return(ApplianceValue);
            WidgetFactoryFake.Stub(x => x.Create(CreateEventArgsValue)).Return(WidgetValue);
            new WidgetCreatePresenter(CreateViewFake, ApplianceRepoFake, WidgetFactoryFake, WidgetRepoFake);
        };

        Because of = () => {
            CreateViewFake.Raise(x => x.WidgetCreateRequested += null, null, CreateEventArgsValue);
        }

        It should_add_the_widget = () => {
            WidgetRepoFake.AssertWasCalled(x => x.Store(WidgetValue));
        }

        It should_show_the_updated_appliance = () => {
            CreateViewFake.AssertWasCalled(x => x.Appliance = ApplianceValue);
        }
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

        protected static IWidgetCreateView CreateViewFake;
        protected static int ApplianceIdValue;
        protected static IApplianceRepository ApplianceRepoFake;
        protected static IAppliance ApplianceValue;
        protected static IWidgetFactory WidgetFactoryFake;
        protected static WidgetCreateEventArgs CreateEventArgsValue;
        protected static IWidget WidgetValue;
        protected static IWidgetRepository WidgetRepoFake;
    }

As more and more scenario classes extend ScenarioObjects, it grows to offer you more and more re-usable fields.
