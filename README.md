ScenarioObjects
===============

You can install ScenarioObjects using [NuGet](http://nuget.org/packages/ScenarioObjects):

<pre>
  PM> Install-Package ScenarioObjects
</pre>

# What is it?

ScenarioObjects is a parent class for your [Machine.Specifications](https://github.com/machine/machine.specifications) scenario classes. With a single place to define the objects that all of your spec classes will share, you write **cleaner spec classes in less time**, creating a ubiquitous, reusable domain language for your test suite.

[Tutorial Videos](https://github.com/lancehilliard/ScenarioObjects/wiki/Videos) are available to help you get started.

# Getting Started with ScenarioObjects

Adding ScenarioObjects to your project adds ScenarioObjects.cs to its root folder. It will contain four methods:

<pre>
  AssignFakes();
  AssignDeliberates();
  AssignArbitraryValues();
  AssignSystemsUnderTest();
</pre>

Documentation appears in your editor above each method. Each method serves a different purpose.

Define field objects your scenario classes will use as your suite of specifications/tests grows. As more and more tests specify the same domain, you'll save more and more time -- the objects/variables you need to compose your next spec are already defined and assigned in ScenarioObjects, ready for use. ScenarioObjects begins to act as an ever-growing vocabulary for your spec classes.

## Without ScenarioObjects

Without ScenarioObjects, you declare fields in your scenario class. These value assignments don't express behavior and bloat your spec class.

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

This noise is repeated in every scenario class. Over and over. You can clean things up a bit with lots of parent classes, but avoiding duplication in the parent classes can lend itself to tests that span multiple files.

## With ScenarioObjects

ScenarioObjects makes your spec classes much smaller and easier to read (don't forget: these classes are documentation for your system!). The class below tests the same behavior as the class above and is **~70% smaller**. It does a better job of communicating the behavior that the spec is designed to protect.

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

Here's what the single ScenarioObjects parent class looks like. Every field in this class is re-usable. Every re-use of a ScenarioObjects field by another spec class lessens the test code you have to maintain.

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

As more and more spec classes use ScenarioObjects, it grows to offer you more and more re-usable fields.
