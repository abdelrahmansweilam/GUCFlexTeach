const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.myFunction = functions.firestore.document("deadlines/{docId}")
    .onCreate((snapshot, context) => {
      const topic = snapshot.data().course_code;
      return admin.messaging().sendToTopic(topic,
          {notification: {title: snapshot.data().course_code,
            body: snapshot.data().title+
            " is now posted on the CMS."}});
    });
