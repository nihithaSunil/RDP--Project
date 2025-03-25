[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-2e0aaae1b6195c2367325f4f02e2d04e9abb55f0b24a779b69b11b9e10269abc.svg)](https://classroom.github.com/online_ide?assignment_repo_id=18858222&assignment_repo_type=AssignmentRepo)
# 67-272: RDP Project - Phase 4

We will continue our project to develop a Roi du Pain online bakery ordering system in this phase. We will focus our efforts on building out the controllers and views to make for an effective front end for our new system. This is a lot a test-driven development in this phase -- we give you all the controller tests and some view tests and your job is to pass these tests. In this process, you will see how our testing suite can serve as documentation and help us define system requirements.

The project must be completed **using Rails 7.0.4 and Ruby 3.1.4 and the gems specified in the Gemfile.**.

**Grading**

This phase will constitute 18 percent of your final course grade and is broken down into the following four components:

1. **Building API Endpoints**: We have a separate document in the `docs` directory discussing the endpoints in detail, as well as samples of the JSON each of them would generate. Please read through this carefully and follow all instructions. Also note that these api controllers are exempt from testing. In total, the creation of controllers and generating the JSON to pass those tests comprise 25 points.

1. **Creation of Controllers**: We have given you all the controller tests that your controllers must pass. (_Note that in this section, when we talk of controllers, we are excluding from testing all API controllers._) Of course, these controllers must also be able to generate the code needed to pass the Cucumber tests, so reading the two sets of tests together is advisable. All tests must pass and the coverage is to be at 100 percent; if you add additional methods that we do not test, expect a substantial penalty. In total, the creation of controllers and passing those tests comprise 40 points.

1. **Creation of Views**: We are going to have you complete key elements of the system front end by building views that directly affect the customer experience. (_Note that in the interest of time, we are not requiring views for every single actor in the system. It would be interesting and more realistic to have you develop the app for bakers, shippers, and managers, but we are trying to keep the workload reasonable._) We have given you a series of Cucumber tests that test the full stack (model-view-controller) for key views; these will help you learn a bit about this form of testing. In building these views, keep in mind design principles that were discussed in class. In total, creating these views and passing the Cucumber tests counts for 30 points of the phase grade.

1. **Search & Design Principles**: To prevent attempts to hack the test suites, we will be manually checking each application to make sure that the key elements are not hard-coded into the response and that all functionality works, even those aspects not tested by cucumber. Also, since the autograder is not great with search, we will test that manually. While doing that, we will also assess the quality of your visual design and ensure that your app is adhering to design principles discussed in class. In total, search functionality is worth 5 points; additional penalties for not following design principles or views/functionality that are broken/incomplete can also occur.

**Checkpoints**

There are two checkpoints for this phase.

1. On **April 6th**, the API endpoints are working and produce the appropriate JSON responses.

2. On **April 13th**, in addition to the previous checkpoint working, all controllers except `CartController` and `OrdersController` must be complete and passing at 100 percent coverage.

All checkpoints are due in your GitHub repository before 11:59pm EST on the date specified. We are not explicitly checking for test coverage on checkpoints, only that the specified tests exist and they pass. Checkpoints will be submitted via GitHub and Gradescope (additional instructions to follow).

**Other Notes**

1. There are no spec files given with regards to controller code this phase -- part of the purpose of this phase is to get you familiar with testing as a form of documentation. **Because of this, if you ask a general question about requirements on Piazza or in office hours, our first response will be to ask you what the tests tell you.** If you have specific questions about the tests and how they work, we are happy to answer those, _but we will not interpret the tests for you -- it's your job to turn those tests into requirements._

1. We have given you a reasonable testing context that can be easily set up with the command: `rails db:contexts`. Note that the autograder will have a tweaked version of the context with slightly different names, prices, and the like, to try to discourage students from hard-coding the responses.

1. Note that the models we've given you are feature complete and no additional methods are needed to complete this phase. That said, we have also given you a few extra methods that were not part of the previous, so reviewing the models would be helpful. If you do feel compelled to add new methods to your models, you are responsible for writing tests for those methods so the coverage remains at 100 percent.

1. We strongly advise you _NOT_ to use `rails generate scaffold ...` but rather `rails generate controller ...` in creating your controller for this phase. (Or even better, just use `touch <filename>` on the command line to generate blank files to work with.) Also, be sure not to overwrite the controller tests if you do use the generators. (Some students _did_ overwrite factories in phase 3 and that caused issues; we will _not_ repost controller tests that might have been overwritten.) Also be forewarned: scaffolding will generate lots of extra code that may inadvertently impact your test coverage and cause you to lose points. We will have no sympathy if you ignore this warning and lose points.

1. We do expect authorization to be put in place at both the controller and view levels, as appropriate. There will be penalties if authorization is not handled properly at the controller or view levels.

1. To make things easier, we have left in the MaterializeCSS framework used to create the solution views, as well as a set of partials we used. You are not required to use this CSS or these partials -- totally your call, so long as things work and look reasonable.

1. To also make things easier, we've also given you a set of screenshots in `docs` to guide you. Note that the screenshots were taken before all cucumber tests were complete, so the data won't match exactly. Note also that there is some functionality in the cucumber tests that are not in the screenshots (not comprehensive) and some screenshot functionality that doesn't have cucumber tests (again, not comprehensive).

1. There are additional methods in the models and in the services that we didn't have you do in Phase 3, but have provided to you for this phase. There is no reason to have to add new methods to the services or models; if you think you need more, look over the starter code and odds are you will find something that will meet your needs.

1. We have given you a module called `Cart` that is in `lib/helpers` and will perform all the functionality that is required for this app to process cart requests. We strongly suggest you review this `Cart` helper prior to building your solution.

1. Doing the checkpoints will keep you from getting too far behind, **but _only_ doing the minimum each week will pretty much ensure a miserable final week.** Our advice, as it has been throughout the semester, is to follow the path but work ahead of the minimum requirements.

**Turning in Phase 4**

Your project should be turned in via your private repository on GitHub **before 11:59 pm (EDT) on Sunday, April 20th, 2025**. Once it's in your repo, you will then submit it from there to Gradescope. More instructions on submitting to the autograder will be posted separately. The solution for this phase (i.e., starter code for the next phase) will be released soon after; no late assignments will be accepted after solutions are released.

Again, if you have questions regarding the turn-in of this project or problems downloading any of the materials below, please post them on Piazza or ask someone well in advance of the turn-in date. Waiting until the day before it is due to get help is unwise -- you risk not getting a timely response that close to the deadline and will not be given an extension because of such an error.
