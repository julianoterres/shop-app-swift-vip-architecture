# iOS Shop App

Hello! This is the steps to run this app in your Xcode

## Architecture

This project was building using the VIP and Clean code and Swift Package Manager to external libs

## Unit Tests

To demonstrate knowledge about unit testing, in this project we carried out unit testing of the HomeInteractor class, which represents the business layer of the Home screen.

## Clone repository

If you don't have git installed in your mac, you need install following the [documentation of git].

[documentation of git]:https://git-scm.com/download/mac

The first step, is clone the repository in your mac. To this create a directory in your mac and open that directory in your terminal app.

When you be inside the app directory in terminal, execute the follow commands below:


	git init
	git remote add origin git@github.com:YOUR_USER/shop-app-swift-vip-architecture.git
	git fetch
	git checkout master

## Run project

After clone project, just open the file Shop.xcodeproj with Xcode and run the project

## API

As the API that was provided was not online, I created a new mocked API for the app to work with the json data sent.

When analyzing the json sent and also the requirements, I verified that the value fields were in String, so I decided to make an improvement, transforming them into Double (in this case, this improvement would be requested from the project's back-end team). Therefore, the app must run on the new API so that everything works correctly.