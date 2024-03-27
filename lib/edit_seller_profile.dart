import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seller_app/backend/databases/users_db.dart';
import 'package:seller_app/backend/models/user_model.dart';
import 'package:seller_app/backend/use_cases/users/edit_user.dart';
import 'package:seller_app/constants.dart';
import 'package:seller_app/local_data.dart';

class EditSellerProfile extends StatefulWidget {


  const EditSellerProfile({Key? key}) : super(key: key);

  @override
  _EditSellerProfileState createState() => _EditSellerProfileState();
}

class _EditSellerProfileState extends State<EditSellerProfile> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: "");
    _lastNameController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _phoneNumberController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _usernameController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: FutureBuilder(
          future: readSingleUser.call(id: firebaseAuth.currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                var user = snapshot.data;
                setState(() {
                  _firstNameController = TextEditingController(text: user.firstName);
                  _lastNameController = TextEditingController(text: user.lastName);
                  _emailController = TextEditingController(text: user.email);
                  _phoneNumberController = TextEditingController(text: user.phoneNumber);
                  _passwordController = TextEditingController(text: user.password);
                  _usernameController = TextEditingController(text: user.username);
                });
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username'
                            ''
                            '',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {

                        // Update user profile with the new data
                        final updatedUser = UserModel(
                            id: firebaseAuth.currentUser!.uid,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            phoneNumber: _phoneNumberController.text,
                            password: _passwordController.text,
                            username: _usernameController.text);

                        editUser.call(updatedUser);
                        Navigator.of(context).pop();
                        print(updatedUser.toMap());
                      },
                      child: const Text('Save Changes'),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
