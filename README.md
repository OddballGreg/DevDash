# README

## Preface

I find Trello to be one of the least taxing applications for use as an organizational tool when developing a piece of software, but find myself often interested in understanding my levels of productivity in the associated project, and my ability to understand the amount of work various things may take.

Being unwilling to change up to a more managerial focused platform like Jira or Teamcity for these purposes, I began using a chrome plugin [Scrum For Trello](https://chrome.google.com/webstore/detail/scrum-for-trello/jdbcdblgjdpmfninkoogcfpnkjmndgje) to easily add estimations and rough work hours to cards after their completion. I would then track these stats in a spreadsheet manually each week.

While this did seem to do the trick at first, I found the process of tracking these stats in trello laboursome and repetitive, into which comes the dev-dash, a tool that can use your Trello API token to monitor and track these states and information directly from these trello boards.


## Setup
You will need to supply a few values in a file called `.env` in order for docker-compose to correctly configure the application. Please follow the `.env-sample` file as a guide for these values.

You can retrieve the trello api key needed for this application from here: https://trello.com/app-key

Configuring the app should be as simple as running the commands listed below:

  - `docker-compose up -d --build`
  - `docker-compose exec web rake db:setup`
  - `docker-compose exec web rake db:migrate`
  - `docker-compose exec web rake db:seed`

After that, just navigate to `localhost` to use the application.

A user is seeded into the database by default. The credentials are:
  - email: test@test.com
  - password: secret

## How Does It Work
  - The DevDash uses the [ruby-trello](https://github.com/jeremytregunna/ruby-trello) gem to engage with the Trello restful developer api using the auth key provided in the env and a token configured within the app after it is running.
  - Once running, pressing the "Refresh" link on the home page or the "Trigger Refresh" in the user drop down on the top right of navbar, will schedule an asynchronous job via Redis to pull the users Trello information and create a local copy.
  - As this occurs, the database models for the users Trello cards look for a a specific syntax relating to the Scrum For Trello app linked earlier in this readme. This syntax involved the card name with a configuration like `(5) Develop the DevDash Applicaiton [8]` whereing the circular brackets denote an estimated time in hours to complete the work unit, and the square brackets denote approximate actual time to complete.
  - Matches of this syntax is stored seperately, and propogated up in a summary style way to the list and board models which are all representative of their Trello counterpart.
  - Once complete, the front end views of the application use the available information to calculate some general stats regarding the users use of Trello including general amount of hours per card/list/board
  - Additionally, the front end uses a case insensitive query to detect lists with certain agile style names like "In Progress", "Code Review" or "Completed This Sprint", and displays the count of cards in these states as appropriate.

## To Do
- Make the app able to service and authenticate multiple users at a time so that it could be deployed online
- Improve the TrelloTracker Service in terms of speed and efficiency. (Currently wipes all data on each run, can take several minutes to process all boards depending on user)
- Develop a way for the application to track stats per board and list over time, allowing historical metrics to be gathered.
- Improve the spec suite, as this application was developed rapidly as a POC, there is no spec suite currently.
- Make the kind of list stats to be tracked configurable, such as allowing the user to configure the type of list names to consider as "In Progress"