import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/signup/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: 'Pawan');
  final _lnameController = TextEditingController(text: 'Chaudhary');
  final _phoneController = TextEditingController(text: '123456789');
  final _usernameController = TextEditingController(text: 'pawan');
  final _passwordController = TextEditingController(text: 'pawan123');

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          context.read<RegisterBloc>().add(
                UploadImage(file: _img!),
              );
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Image
          // Positioned.fill(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage(
          //             'assets/images/background.png'), // Change to your image path
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          // Foreground content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.grey[300],
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _browseImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.camera),
                                    label: const Text('Camera'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _browseImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.image),
                                    label: const Text('Gallery'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _img != null
                                ? FileImage(_img!)
                                : const AssetImage('assets/images/profile.png')
                                    as ImageProvider,
                          ),
                        ),
                      ),
                      const Text(
                        '',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Brand Bold',
                        ),
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: _fnameController,
                        decoration:
                            const InputDecoration(labelText: 'First Name'),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter first name'
                            : null,
                      ),
                      _gap,
                      TextFormField(
                        controller: _lnameController,
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter last name'
                            : null,
                      ),
                      _gap,
                      TextFormField(
                        controller: _phoneController,
                        decoration:
                            const InputDecoration(labelText: 'Phone No'),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter phone number'
                            : null,
                      ),
                      _gap,
                      TextFormField(
                        controller: _usernameController,
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter username'
                            : null,
                      ),
                      _gap,
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter password'
                            : null,
                      ),
                      _gap,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              final registerState =
                                  context.read<RegisterBloc>().state;
                              final imageName = registerState.imageName;
                              context.read<RegisterBloc>().add(
                                    RegisterStudent(
                                      context: context,
                                      fName: _fnameController.text,
                                      lName: _lnameController.text,
                                      phone: _phoneController.text,
                                      username: _usernameController.text,
                                      password: _passwordController.text,
                                      image: imageName,
                                    ),
                                  );
                            }
                          },
                          child: const Text('Register'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
