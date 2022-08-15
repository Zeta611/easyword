import { initializeApp, getApps } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getFirestore, collection, query, orderBy, onSnapshot, addDoc } from "firebase/firestore";
import { getAuth } from 'firebase/auth';

// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
  storageBucket: import.meta.env.VITE_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID,
  appId: import.meta.env.VITE_FIREBASE_APP_ID,
  measurementId: import.meta.env.VITE_FIREBASE_MEASUREMENT_ID
};

function initializeServices() {
  const isConfigured = getApps().length > 0;
  const firebaseApp = initializeApp(firebaseConfig);
  const analytics = getAnalytics(firebaseApp);
  const firestore = getFirestore(firebaseApp);
  const auth = getAuth(firebaseApp);
  return { firebaseApp, analytics, firestore, auth, isConfigured };
}

export function getFirebase() {
  const services = initializeServices();
  return services;
}

export function streamJargons() {
  const { firestore } = getFirebase();
  const jargonsCol = collection(firestore, "jargons");
  const jargonsQuery = query(jargonsCol, orderBy("english"));
  return (callback) => onSnapshot(jargonsQuery, snapshot => {
    const jargons = snapshot.docs.map(doc => {
      // const isDelivered = !doc.metadata.hasPendingWrites;
      return { id: doc.id, ...doc.data() }
    });
    callback(jargons);
  });
}

export function addJargon(english, korean) {
  const { firestore } = getFirebase();
  return addDoc(collection(firestore, "jargons"), {
    english: english,
    korean: korean
  });
}
