# Admin Feature Setup Guide

## Overview
This guide explains how to set up and use the admin feature in the NHA-224 e-commerce Flutter app. The admin panel allows authorized users to manage products and categories with Cloudinary image hosting integration.

---

## App Flow (Splash → Login → Dashboard/Home)

### 1. **Splash Screen** (Initial Route)
- The app launches at `lib/features/Auth/presentation/splash_screen.dart`
- Displays the app brand ("Vevo") for ~900ms
- Automatically navigates to the login screen

### 2. **Login Screen**
- User enters email and password (or signs in with Google)
- On successful login:
  - The app fetches the user's Firestore document: `users/{uid}`
  - Reads the `role` field from that document
  - **If `role == 'admin'` or `role == 'superadmin'`**: routes to Admin Dashboard
  - **Otherwise**: routes to the main app layout (home page)

### 3. **Admin Dashboard** (If user is admin)
- Located at `lib/features/admin/admin_dashboard.dart`
- Displays buttons to navigate to:
  - **Add Category** (`lib/features/admin/add_category_page.dart`)
  - **Add Product** (`lib/features/admin/add_product_page.dart`)
- Re-validates admin role on entry (double-check guard)

### 4. **Main App Layout** (If user is regular user)
- Located at `lib/features/layout/BottomNavLayout.dart`
- Shows home, orders, notifications, and profile screens

---

## How to Create an Admin User

### Method 1: Manual Setup (Fastest for Testing)

1. **Register a new account**
   - Open the app
   - Go to the Register page
   - Create an account with any email and password
   - Verify your email (check inbox for verification link)

2. **Promote user to admin in Firebase Console**
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Select your project
   - Navigate to **Firestore Database** > **Collections**
   - Find the **`users`** collection
   - Locate your user document (the UID is in Auth > Users)
   - Edit the document and add/update the field:
     ```
     role: "admin"  (string type)
     ```

3. **Log in as admin**
   - Use the same email and password to log in
   - The app will detect `role == "admin"` and route to Admin Dashboard

### Method 2: Using Firebase CLI (For Batch Operations)

If you have multiple admin users or want to automate:

```bash
firebase firestore:set "users/{USER_UID}" --data role=admin --merge
```

---

## Cloudinary Image Upload Configuration

### Why Cloudinary?
- Secure, scalable image hosting
- Unsigned client-side uploads (no server needed initially)
- Returns secure URLs for Firestore storage
- Free tier supports up to 25GB storage

### Setup Steps

1. **Create a Cloudinary Account**
   - Go to [Cloudinary.com](https://cloudinary.com)
   - Sign up for a free account
   - Navigate to the Dashboard

2. **Get Your Cloud Name**
   - In Cloudinary Dashboard, copy your **Cloud Name** (e.g., `dppqrdzf6`)

3. **Create an Unsigned Upload Preset**
   - Go to **Settings** > **Upload**
   - Scroll to **Upload presets**
   - Click **Add upload preset**
   - Set **Mode** to `Unsigned`
   - Name it (e.g., `images`)
   - Click **Save**

4. **Update Config in Flutter App**
   - Open `lib/core/config.dart`
   - Replace placeholders:
     ```dart
     const String kCloudinaryCloudName = 'your-cloud-name';
     const String kCloudinaryUploadPreset = 'your-preset-name';
     ```
   - Save the file

5. **Test Image Upload**
   - Log in as admin
   - Go to Admin Dashboard → Add Product
   - Select images and submit
   - Verify images upload and URLs appear in Firestore

### Important Security Notes
- **Do NOT embed your Cloudinary API Secret** in the Flutter app (it's for server-side only)
- For **deleting images**, set up a server-side endpoint using the API Secret
- Unsigned uploads are safe and sufficient for client-side operations

---

## Admin Panel Features

### Add Category
- **Location**: Admin Dashboard → "Add Category"
- **Fields**:
  - Category name (required, non-empty)
  - Image (required, picked from gallery)
- **Action**: Uploads image to Cloudinary, stores category in Firestore
- **Result**: Category appears in app's category list

### Add Product
- **Location**: Admin Dashboard → "Add Product"
- **Fields**:
  - Product name (required)
  - Description (required)
  - Price (required, must be > 0)
  - Old price (optional)
  - Stock (default: 0)
  - Colors (comma-separated, e.g., "red,blue,green")
  - Sizes (comma-separated, e.g., "S,M,L,XL")
  - Brand (optional)
  - SKU (optional)
  - Gender (dropdown: Unisex, Male, Female)
  - Category (dropdown, auto-populated from Firestore)
  - Multiple images (required, min 1)
- **Action**: Uploads all images to Cloudinary, stores product in Firestore
- **Result**: Product appears in shop and search results

---

## Firestore Data Schema

### Users Collection
```
users/
  {uid}/
    uid: string
    name: string
    email: string
    profileImageUrl: string
    role: "user" | "admin" | "superadmin"  ← Key field for routing
    createdAt: timestamp (optional)
```

### Categories Collection
```
categories/
  {categoryId}/
    id: string
    name: string
    imageUrl: string (Cloudinary secure_url)
    createdAt: timestamp
```

### Products Collection
```
products/
  {productId}/
    id: string
    name: string
    description: string
    price: number
    oldPrice: number (optional)
    rating: number
    stock: number
    productId: string
    colors: array<string>
    sizes: array<string>
    imageUrl: array<string> (Cloudinary URLs)
    category: DocumentReference (ref to categories/{categoryId})
    gender: "Unisex" | "Male" | "Female"
    brand: string (optional)
    sku: string (optional)
    isFeatured: boolean
    createdAt: timestamp
    updatedAt: timestamp
```

---

## Routing Map

| Route | Initial? | Component | Guards |
|-------|----------|-----------|--------|
| `/splash` | ✅ Yes | SplashScreen | None |
| `/login` | No | LoginPage | None |
| `/admin/dashboard` | No | AdminDashboard | `role == 'admin'` |
| `/admin/addCategory` | No | AddCategoryPage | `role == 'admin'` |
| `/admin/addProduct` | No | AddProductPage | `role == 'admin'` |
| `/` (home layout) | No | BottomNavLayout | None |
| `/search` | No | SearchPage | None |
| `/productDetails` | No | ProductDetailsPage | None |
| etc. | No | Other screens | None |

---

## Troubleshooting

### Admin Dashboard Not Showing After Login
- **Check**: Firestore `users/{uid}.role` field exists and equals `'admin'` (case-sensitive, lowercase)
- **Fix**: Edit the user document in Firebase Console and ensure the role field is set correctly

### Images Not Uploading
- **Check**: Cloudinary config in `lib/core/config.dart` is populated correctly
- **Check**: The unsigned upload preset exists and is enabled in Cloudinary
- **Check**: Device has internet connection and Cloudinary API is accessible
- **Fix**: Run `flutter analyze` and check for any remaining issues, then rebuild

### Access Denied on Admin Pages
- **Reason**: You're logged in as a regular user (role != 'admin')
- **Fix**: Follow "How to Create an Admin User" section to promote your account

### Firestore Security Rules
- Ensure your Firestore rules allow:
  - Authenticated users to read/write to `users/{uid}` (their own document)
  - Admin users to read/write to `categories` and `products` collections
  - Example rule for admin panel:
    ```
    match /categories/{categoryId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
                      get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role in ['admin', 'superadmin'];
    }
    ```

---

## Testing Checklist

- [ ] App starts at splash screen
- [ ] Splash screen routes to login after delay
- [ ] Regular user login routes to home layout
- [ ] Admin user login routes to admin dashboard
- [ ] Admin can add a category with image
- [ ] Admin can add a product with multiple images
- [ ] Products and categories appear in Firestore
- [ ] Product images load from Cloudinary in the app
- [ ] Non-admin users cannot access admin pages
- [ ] Admin dashboard has "Return Home" button for fallback

---

## Next Steps (Optional Enhancements)

1. **Server-Side Admin Management**
   - Create a Node.js/Express endpoint to securely promote/demote users
   - Validate requests with Firebase Admin SDK

2. **Cloudinary Image Deletion**
   - Build a backend endpoint using Cloudinary API Secret
   - Wire delete operations to remove images when products/categories are deleted

3. **Admin Activity Logging**
   - Track who added/edited/deleted products and categories
   - Store logs in Firestore for audit purposes

4. **Role-Based Access Control (RBAC)**
   - Extend roles: `user`, `admin`, `superadmin`, `moderator`
   - Different permissions per role

5. **Bulk Operations**
   - CSV import for products
   - Batch delete categories/products
   - Price adjustments across categories

---

## Support

For issues or questions:
1. Check Firestore rules are correct
2. Verify Cloudinary config values
3. Ensure user's Firebase email is verified
4. Check browser console/Logcat for error messages
5. Run `flutter clean && flutter pub get` to reset dependencies

---

**Last Updated**: 2025-11-15  
**App Version**: 1.0.0  
**Admin Feature Status**: Ready for Testing ✅
