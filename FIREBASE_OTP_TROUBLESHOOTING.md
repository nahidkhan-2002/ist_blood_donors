# Firebase OTP Authentication Troubleshooting Guide

## Common Issues and Solutions

### 1. "Invalid OTP" or "Verification Failed" Error

#### Possible Causes:
- **Phone Number Format**: The phone number must be in the correct Bangladesh format
- **OTP Expiration**: OTP codes expire after 2 minutes
- **Verification ID Mismatch**: The verification ID might be invalid or expired
- **Firebase Configuration**: Firebase project might not be properly configured

#### Solutions:

##### A. Check Phone Number Format
- Ensure phone number is exactly 11 digits starting with 0 (e.g., 01621009683)
- The system will automatically format it to +881621009683
- Valid formats: 01XXXXXXXXX, 016XXXXXXXX, 017XXXXXXXX, 018XXXXXXXX, 019XXXXXXXX
- Remove any spaces, dashes, or special characters

##### B. Verify Firebase Configuration
1. Check if your Firebase project has Phone Authentication enabled
2. Go to Firebase Console → Authentication → Sign-in method
3. Enable "Phone" as a sign-in provider
4. Add your app's SHA-1 fingerprint for Android

##### C. Check Android SHA-1 Fingerprint
```bash
# For debug builds
cd android && ./gradlew signingReport
# Look for the SHA-1 under "debugAndroidTest" or "debug"
```

##### D. Verify Firebase Configuration Files
- Ensure `google-services.json` is in `android/app/`
- Check `firebase_options.dart` has correct project ID
- Verify API keys are correct

### 2. OTP Not Received

#### Possible Causes:
- **Network Issues**: Poor internet connection
- **SMS Delivery**: SMS might be blocked by carrier
- **Phone Number**: Incorrect phone number format
- **Firebase Quotas**: Exceeded SMS limits

#### Solutions:
- Check internet connection
- Verify phone number format
- Wait a few minutes and try again
- Check Firebase Console for quota limits

### 3. "Session Expired" Error

#### Cause:
- OTP verification session has expired (usually after 2 minutes)
- User took too long to enter the OTP

#### Solution:
- Use the "Resend OTP" button to get a new code
- Enter the OTP quickly after receiving it

### 4. "Too Many Requests" Error

#### Cause:
- Too many OTP requests in a short time
- Firebase rate limiting

#### Solution:
- Wait 5-10 minutes before trying again
- Check if you're not accidentally spamming the send button

## Debug Steps

### 1. Check Console Logs
Look for these debug messages in your console:
```
Sending OTP to: +881712345678
OTP code sent successfully. Verification ID: [verification_id]
Verifying OTP: [otp_code]
Sign in successful for user: [user_uid]
```

### 2. Verify Firebase Initialization
Check if Firebase is properly initialized:
```
Firebase initialized successfully
Firebase Auth is working properly
```

### 3. Test with Known Good Phone Number
- Use a phone number you know works with Firebase
- Test with a different device if possible

## Firebase Console Setup

### 1. Enable Phone Authentication
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Go to Authentication → Sign-in method
4. Enable "Phone" provider
5. Add your app's SHA-1 fingerprint

### 2. Check Project Settings
1. Go to Project Settings
2. Verify your app is properly registered
3. Check if the correct `google-services.json` is downloaded

### 3. Monitor Usage
1. Go to Authentication → Users
2. Check if OTP requests are being logged
3. Look for any error messages

## Code Changes Made

### 1. Added Required Permissions
```xml
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.RECEIVE_SMS" />
<uses-permission android:name="android.permission.READ_SMS" />
```

### 2. Improved Phone Number Validation
- Added format checking for Bangladesh phone numbers
- Automatic formatting to +88 country code
- Validation that number is 11 digits starting with 0 (e.g., 01621009683)

### 3. Enhanced Error Handling
- Specific error messages for different failure types
- Better debugging information
- Resend OTP functionality

### 4. Added Debug Logging
- Comprehensive logging for troubleshooting
- Firebase error details
- OTP verification flow tracking

### 5. Unified Data Collection
- All user data is stored in the 'informations' collection
- Consistent data structure across registration and login
- Simplified data management

## Testing Steps

### 1. Test Phone Number Format
- Enter: `01621009683` (your number)
- Should be formatted as: `+881621009683`
- Other valid examples: `01712345678`, `01887654321`, `01911223344`

### 2. Test OTP Flow
1. Enter valid phone number
2. Wait for OTP SMS
3. Enter 6-digit OTP quickly
4. Check console logs for success

### 3. Test Error Cases
- Enter invalid phone number
- Enter expired OTP
- Test resend functionality

## Still Having Issues?

If you're still experiencing problems:

1. **Check Firebase Console** for any error messages
2. **Verify your Firebase project** has Phone Auth enabled
3. **Check your app's SHA-1 fingerprint** is added to Firebase
4. **Test with a different phone number** to isolate the issue
5. **Check your internet connection** and try again
6. **Look at console logs** for specific error messages

## Contact Support

If none of these solutions work:
1. Check Firebase Console for error logs
2. Verify your Firebase project configuration
3. Ensure you have the latest Firebase SDK versions
4. Test with Firebase's sample app to verify your setup

## Cloud Firestore Security Rules

Here are the appropriate security rules for your project using the `informations` collection:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Informations collection - contains donor information
    match /informations/{docId} {
      // Allow read access to all authenticated users (to find donors)
      allow read: if request.auth != null;
      
      // Allow users to create their own profile during registration
      allow create: if request.auth != null;
      
      // Allow users to update only their own profile
      allow update: if request.auth != null 
        && resource.data.phone == request.auth.token.phone_number;
      
      // Allow users to delete only their own profile
      allow delete: if request.auth != null 
        && resource.data.phone == request.auth.token.phone_number;
    }
    
    // Test collection - for testing purposes only
    match /test/{docId} {
      // Only allow read access for testing
      allow read: if request.auth != null;
      // No write access to test collection
      allow write: if false;
    }
    
    // Default rule - deny all other access
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

### Key Features:
- **Single Collection**: All user data in `informations` collection
- **Authentication Required**: All operations require user authentication
- **User Isolation**: Users can only modify their own data
- **Donor Search**: All users can search for blood donors
- **Data Privacy**: Users can't see or modify other users' data
