import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/core/resources/ColorManager.dart';
import '../widgets/avatar_picker.dart';
import '../widgets/custom_text_field.dart';
import '../profile_screen/ProfileTab.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = "/edit-profile";
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String selectedAvatar = "assets/images/avatar 3.png";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  get _firestore => null;





  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          nameController.text = data['name'] ?? '';
          phoneController.text = data['phone'] ?? '';
          selectedAvatar = data['avatar'] ?? selectedAvatar;
        });
      }
    }
  }

  // Update user data in Firestore
  Future<void> _updateAccount() async {
    if (_formKey.currentState!.validate()) {
      final user = _auth.currentUser;
      if (user != null) {
        try {
          var _firestore;
          await _firestore.collection('users').doc(user.uid).update({
            'name': nameController.text.trim(),
            'phone': phoneController.text.trim(),
            'avatar': selectedAvatar,
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data Updated!')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  // Delete user account from Firebase Auth and Firestore
  Future<void> _deleteData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account Deleted!')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorManager.yellow),
          centerTitle: true,
          title: GestureDetector(
            onTap: () {
              AvatarPicker(
                selectedAvatar: selectedAvatar,
                onAvatarSelected: (newAvatar) {
                  setState(() {
                    selectedAvatar = newAvatar;
                  });
                },
                openSheet: () {},
              ).showAvatarSheet(context);
            },
            child: Text(
              "Pick Avatar",
              style: TextStyle(
                color: ColorManager.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                AvatarPicker(
                  selectedAvatar: selectedAvatar,
                  onAvatarSelected: (newAvatar) {
                    setState(() {
                      selectedAvatar = newAvatar;
                    });
                  },
                  openSheet: () {
                    AvatarPicker(
                      selectedAvatar: selectedAvatar,
                      onAvatarSelected: (newAvatar) {
                        setState(() {
                          selectedAvatar = newAvatar;
                        });
                      },
                      openSheet: () {},
                    ).showAvatarSheet(context);
                  },
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: nameController,
                        hintText: "User Name",
                        textStyle: TextStyle(color: ColorManager.white),
                        fillColor: ColorManager.darkGray,
                        icon: SvgPicture.asset(
                          'assets/svg/user_icon.svg',
                          width: 24,
                          height: 24,
                          color: ColorManager.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Please enter a name";
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: phoneController,
                        hintText: "Phone Number",
                        textStyle: TextStyle(color: ColorManager.white),
                        fillColor: ColorManager.darkGray,
                        icon: SvgPicture.asset(
                          'assets/svg/phone_icon.svg',
                          width: 24,
                          height: 24,
                          color: ColorManager.white,
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) return "Please enter a phone number";
                          if (!RegExp(r'^\d{11}$').hasMatch(value)) return "Phone number must be 11 digits";
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Reset Password',
                  style: TextStyle(color: ColorManager.white, fontSize: 16),
                ),
                const SizedBox(height: 230),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.yellow,
                      foregroundColor: ColorManager.darkGray,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _updateAccount,
                    child: const Text(
                      "Update Data",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _deleteData,
                    child: const Text(
                      "Delete Account",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
