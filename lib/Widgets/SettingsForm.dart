import "package:brew_crew/Models/DataOfUser.dart";
import "package:brew_crew/Models/User.dart";
import "package:brew_crew/Services/database.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final formKey = GlobalKey<FormState>();
  final List<String> sugarSpoons = ["0", "1", "2", "3", "4", "5"];
  String? currentName;
  String? currentSugar;
  int? currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return StreamBuilder<UData>(
        stream: DatabaseService(user.uid).DataOfUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UData? data = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Text(
                      "Update Your Brew Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: data?.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black.withOpacity(0.5))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.black, width: 2)),
                      ),
                      onChanged: (value) {
                        setState(() {
                          currentName = value; // Update currentName when the text changes
                        });
                      },
                    ),                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                        value: currentSugar ?? (data?.sugar ?? "0"),
                        decoration: InputDecoration(
                          hintText: 'Sugar',
                          prefixIcon: const Icon(Icons.restaurant_menu),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.5))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2)),
                        ),
                        items: sugarSpoons
                            .map((sugar) => DropdownMenuItem(
                                  value: sugar,
                                  child: Text("$sugar spoons"),
                                ))
                            .toList(),
                        onChanged: (val) => setState(() {
                              currentSugar = val;
                            })),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 22.0),
                          child: Text(
                            "Strength",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Slider(
                          activeColor: Colors.brown[
                              (currentStrength ?? (data?.strength ?? 100))
                                  .clamp(0, 900)],
                          inactiveColor: Colors.brown[
                              (currentStrength ?? (data?.strength ?? 100))
                                  .clamp(0, 900)],
                          min: 100.0,
                          max: 900.0,
                          divisions: 8,
                          value: (currentStrength ?? (data?.strength ?? 100))
                              .toDouble(),
                          onChanged: (value) {
                            setState(() {
                              currentStrength =
                                  value.toInt(); // Update currentStrength
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await DatabaseService(user.uid).updateUserData(
                            currentSugar ?? (data?.sugar ?? "0"),
                            currentName ?? (data?.name ?? ''),
                            currentStrength ?? (data?.strength ?? 100),
                          );
                          // Update the stream after updating the data
                          DatabaseService(user.uid).updateUserData(
                            currentSugar ?? (data?.sugar ?? "0"),
                            currentName ?? (data?.name ?? ''),
                            currentStrength ?? (data?.strength ?? 100),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Update"),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
