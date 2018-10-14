# README

## Preface

I find Trello to be one of the least taxing applications for use as an organizational tool when developing a piece of software, but find myself often interested in understanding my levels of productivity in the associated project, and my ability to understand the amount of work various things may take.

Being unwilling to change up to a more managerial focused platform like Jira or Teamcity for these purposes, I began using a chrome plugin [Scrum For Trello](https://chrome.google.com/webstore/detail/scrum-for-trello/jdbcdblgjdpmfninkoogcfpnkjmndgje) to easily add estimations and rough work hours to cards after their completion. I would then track these stats in a spreadsheet manually each week.

While this did seem to do the trick at first, I found the process of tracking these stats in trello laboursome and repetitive, into which comes the dev-dash, a tool that can use your Trello API token to monitor and track these states and information directly from these trello boards.


## Setup
You will need to supply a few values in a file called `.env` in order for docker-compose to correctly configure the application. Please follow the `.env-sample` file as a guide for these values.

You can retrieve the trello api key needed for this application from here: https://trello.com/app-key

`docker-compose up -d --build && docker-compose exec web rake db:setup`

## To Do
- Make the app able to service multiple users at a time so that it could be deployed online
- Improve the TrelloTracker Service in terms of speed and efficiency. (Currently wipes all data on each run)
- Develop a way for the application to track stats per board and list over time