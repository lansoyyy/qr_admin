import 'package:flutter/material.dart';
import 'package:metro_admin/services/add_user.dart';
import 'package:metro_admin/widgets/text_widget.dart';

class InputDialog extends StatefulWidget {
  const InputDialog({super.key});

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _contactNumber = '';
  String _address = '';
  String _position = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Input Details'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Full Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
              onChanged: (value) {
                _fullName = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email Address'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email address';
                }
                return null;
              },
              onChanged: (value) {
                _email = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Contact Number'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your contact number';
                }
                return null;
              },
              onChanged: (value) {
                _contactNumber = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
              onChanged: (value) {
                _address = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Position/Role'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your position/role';
                }
                return null;
              },
              onChanged: (value) {
                _position = value;
              },
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          child: TextBold(text: 'Save', fontSize: 18, color: Colors.blue),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // Do something with the data

              addUser(_fullName, _email, _contactNumber, _address, _position);

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
