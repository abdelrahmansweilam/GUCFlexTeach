const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.myFunction = functions.firestore.document("notifications/{docId}")
    .onCreate((snapshot, context) => {
      const topic = snapshot.data().course_code;
      return admin.messaging().sendToTopic(topic,
          {notification: {title: snapshot.data().title,
            body: snapshot.data().body}});
    });
