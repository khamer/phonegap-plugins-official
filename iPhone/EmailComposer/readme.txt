To use this version of the plugin, you'll need to add both MessageUI.framework
as well as Base64 library like this one:

* http://www.cocoadev.com/index.pl?BaseSixtyFour

You will need to add MessageUI.framework to your project if it is not already
included. Just add the .m.h files to your project ( you can add them directly
to your own project, you don't need to put them in phonegap lib ). Place the
.js file in your app root, and include it from your html. This is intended to
also demonstrate how to pass arguments to native code using the options/map
object. Please review the js file to understand the interface you can call, and
reply with any questions.
