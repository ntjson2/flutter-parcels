const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const firebaseConfig = require("./firebaseConfig");
const admin = require("firebase-admin");
admin.initializeApp(firebaseConfig.firebaseConfig);
const db = admin.firestore();


const minRef = db.collection('njflutter').doc('minerals');
exports.minRefFn = onRequest((request, response) => {
        console.log(request.query)    

        minRef.get().then((doc) => {
            if (doc.exists){
                console.log("Updated Document!");   
                response.send("Minerals ->: " + JSON.stringify(doc.data()));
            }
            else{
                console.log("No such Document!");                
                response.send("No such Document, check the logs");
            }
          }).catch((error) => {
            console.log("Error getting document:", error);
            response.send("Error getting document, check the logs");
          });   
});


const parcelData = db.collection('njflutter').doc('parcels');
exports.parcelData = onRequest((request, response) => {
        console.log(request.query)    

        parcelData.get().then((doc) => {
            if (doc.exists){
                console.log("Getting Document! ");  
                console.log(request.query);
                var index = request.query.index;
                console.log(index);
                console.log(doc.data()[index][0]);
                //const parcel = doc.data().parcels[request.query.parcel];
                //const img = doc.data().img;
                //console.log("Image value:", img);
                //response.send(JSON.stringify(doc.data()));
                response.send(JSON.stringify(doc.data()[index]));
            }
            else{
                console.log("No such Document!");                
                response.send("No such Document, check the logs");
            }
          }).catch((error) => {
            console.log("Error getting document:", error);
            response.send("Error getting document, check the logs");
          });   
});