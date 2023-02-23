# CMSC436 Project Proposal: Squirrel.io

## Project Group 4: Team FAJAM-as

 * Mike Amaya
 * Alex Chen
 * Andrew Hong
 * Fabrizzio Perez
 * Jessica Wu

## App Description

We will be creating a social media app for UMD students. 
The social media app will have squirrel pictures with GPS 
location as to where the person found the squirrel. 
Users will be able to interact with squirrel posts with likes and comments. 
Additionally, people will be able to see a feed of 
squirrel pictures, in chronological order, most recent at the top.

## Minimal Goals

This app will contain a feed of squirrel pictures with an interface that allows 
the user to engage with other posts (i.e. likes and comments)

 * It should include the following features:
 	* Account creation: Users need to able to make accounts prior to posting
 	* Location of photos (GPS requirement): When creating a post, users can tag a location on a squirrel post so others can see the location.
 	* Likes: Users will be able to see total likes, and like squirrel posts.
 	* Ability to post: Users will be able to post squirrel pictures.
 	* Feed (ability to sort based on certain criteria): Users will have a main feed where they can see the latest squirrel pictures. Latest pictures will be towards the top. 

## Stretch Goals

We have identified the following stretch goals:

 * Users will be able to comment on posts
 	* Filter out profane comments
 	* Comment replies
 * Filtering out irrelevant posts (i.e. those that are non-squirrel related)
 	* This could be done with admin roles or a downvoting system
 * Squirrel of the day
 * Infinite scrolling/pagination
 * Push notifications (for posts, likes and comments)

## Project Timeline

### Milestone 1

 * Establish a landing page 
 	* User will be able to login or create an account
 * Account creation/authentication (Firebase)
 	* To keep things simple, we plan to use Google accounts to create accounts
 * Creating UI for a single post component
 	* No real photos will be included in this step
 	* Basic features
		* Profile picture
		* Name
		* Logout button
		* Image box where photos will theoretically be viewed by the user. Hopefully, we’ll either have a dummy image or some text viewable.
 * Account handling (logging out/in)
 	* Displaying name of user (we can obtain this from the Google account)
 	* The user should be able to log out of their account 

### Milestone 2

 * The ability to post images
 	* Also have the ability to share ones location using GPS
 * Ability to create main feed (UI/frontend)
	* Primarily for testing: using dummy data on the backend
	* Scroll through photos/load photos
	* Visible comment component for later functionality

### Milestone 3

 * Ability to delete your own posts
 * Engagement system
 	* Keeping track of the the number of likes on a post
 * Ability to view your own posts 

At this point, we will begin working on the stretch goals

### Final submission

Stretch goals completed, project submitted, and a demonstration scheduled.

