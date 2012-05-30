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

TODO -- show before/after examples demonstrating power of ScenarioObjects for cleaning up the scenario classes