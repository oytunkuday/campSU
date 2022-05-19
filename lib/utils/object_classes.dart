import 'package:flutter/material.dart';


class userInfo{
  var userName;
  var numFollowers;
  var followerArray = [];
  var numFollowed;
  var followedArray = [];
  var nmPosts;
  var profilePic;
  var biology;

  showUser(){
    print('User Name is: ${this.userName}');
    print('Number of followers is: ${this.numFollowers}');
    print('Number of followed people is: ${this.numFollowed}');
    print('Number of posts is: ${this.nmPost}');
    print('Users biology is ${this.biology}');
    print('URL of the profile picture is: ${this.profilePic}');
  }

  showFollowers(){
    print(followerArray);
  }

  showFollowed(){
    print(followedArray);
  }
}

class postInfo{
  var nmLikes;
  var likesArray = [];
  var nmcomments;
  var commentArray = [];
  var pictureURL;

  showPost() {
    print('Number of likes is: ${this.nmLikes}');
    print('Number of comments is: ${this.nmComments}');
    print('URL of the picture: ${this.pictureURL}');
  }

  showCommenters(){
    print(this.commentArray);
  }

  showLikers(){
    print(this.likesArray);
  }

}

class searchResult(){
var searchedWords;
var searchStorage = [];

addtoStorage(var searched){
this.searchStorage.add(searched);
}

}

class notification(){
var username;
var event;

notify(){
switch(this.event){
case 'like':{
print('${this.username} liked your post.');
}
break;

case 'comment':{
print('${this.username} has commented on your post.');
}
break;

case 'follow':{
print('${this.username} followed you.')
}
break;

case 'mention':{
print('${this.username} has mentioned you in a post.')
}
break;
}
}
}
