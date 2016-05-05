# AlbumTrackr-iOS

AlbumTrackr is a project that has the main objective of creating an app that will provide music fans the latest updates about the artists that they like.

This project also has an ongoing, like this one, Android version and can be found at:

 - [AlbumTrackr-Android](https://github.com/leoassuncao/albumtracker)

## Showcase

<p align="center">
<img src="showcase/newsfeed.gif" align="center"  hspace="20">
<img src="showcase/profile.gif" align="center">
<img src="showcase/artistdetail.gif" align="center" hspace="20">
</p>

## Features and General Characteristics

### News Feed

```
STATUS: ONGOING
```

This screen will hold all the updates from the followed artists. The news that appear in the feed will be also pushed to the users. The updates will have 4 main types:

 - Single
 - EP
 - Album
 - Other

This screen is also inteded to support social networking features like posts, liking and/or comments.

### Profile

```
STATUS: ONGOING
```

This screen will store the user image, its name and also its nickname. In a list, below the profile summary, will be stored the artists followed by the user. If the user wants it will be able to see the artist discography by clicking in the list, the user will also be able to unfollow an artist.

### Settings

```
STATUS: ONGOING
```

This screen will hold all settings that will be provided to the user. They'll be related to managing the account, notifications and help.

### Search and Artist Addition

```
STATUS: ONGOING
```

This screen will make possible for the user to look for its favorites artists and consequently adding them to its followed artists list. Once you start following an artist you will start receiving its updates and will also be able to see its discography.

### Localization

```
STATUS: ONGOING
```

Currently the appliaction is being localized in the following languages:

 - English (US)
 - Portuguese (BR)

## Known issues

 - [SOLVED] ~~In the Profile view when you unfollow an artist the cells that are not appearing in the screen,at the moment, have an weird behavior~~ [SOLUTION] The image was missing a constraint to the cell, the constraint was connected to the content view
 - In the Artist view, after you choose an artist form the Profile view, the back button is showing the name of the previous view, but should not be likes this

## Next steps

 - Finish implementing the UI features
 - Build the backend services
 - Connect UI to backend
 - Write unit tests
 - Write UI tests

## Special Thanks

 - [Icons8](https://icons8.com/) for providing free great icons!