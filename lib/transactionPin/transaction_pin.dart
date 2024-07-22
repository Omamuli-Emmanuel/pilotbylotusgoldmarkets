import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../BottomNav/bottomNav.dart';

class TransactionPin extends StatefulWidget {
  final Map<String, dynamic> user;
  const TransactionPin({required this.user});

  @override
  State<TransactionPin> createState() => _TransactionPinState();
}

class _TransactionPinState extends State<TransactionPin> {
  bool _isLoading = false;
  final List<String> _pin = ['', '', '', ''];
  final List<String> _confirmPin = ['','','',''];

  final List<String> _oldPin = ['','','',''];
  String oldPinUpdate = "";
  final List<String> _newPin = ['','','',''];
  final List<String> _confirmNewPin = ['','','',''];

  void _showBottomSheetPin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _addDigit(int digit) {
              setState(() {
                for (int i = 0; i < _pin.length; i++) {
                  if (_pin[i].isEmpty) {
                    _pin[i] = digit.toString();
                    break;
                  }
                }
              });
            }

            void _removeLastDigit() {
              setState(() {
                for (int i = _pin.length - 1; i >= 0; i--) {
                  if (_pin[i].isNotEmpty) {
                    _pin[i] = '';
                    break;
                  }
                }
              });
            }

            return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Enter your new transaction pin',
                          style: GoogleFonts.dmSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: 60,
                              height: 60,
                              child: Center(
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _pin[index].isEmpty ? Colors.grey : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: 12,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.5,
                          ),
                          itemBuilder: (context, index) {
                            if (index == 9) {
                              return GestureDetector(
                                onTap: _removeLastDigit,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.backspace),
                                ),
                              );
                            } else if (index == 10) {
                              return GestureDetector(
                                onTap: () {
                                  _addDigit(0);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFa5b4fc),
                                    borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            } else if (index == 11) {
                              return GestureDetector(
                                onTap: () {
                                  if (_pin.every((digit) => digit.isNotEmpty)) {
                                    Navigator.pop(context);
                                    _showBottomSheetConfirmPin(context);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  _addDigit(index + 1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFa5b4fc),
                                    borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
          },
        );
      },
    );
  }
  void _showBottomSheetConfirmPin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _addDigit(int digit) {
              setState(() {
                for (int i = 0; i < _confirmPin.length; i++) {
                  if (_confirmPin[i].isEmpty) {
                    _confirmPin[i] = digit.toString();
                    break;
                  }
                }
              });
            }

            void _removeLastDigit() {
              setState(() {
                for (int i = _confirmPin.length - 1; i >= 0; i--) {
                  if (_confirmPin[i].isNotEmpty) {
                    _confirmPin[i] = '';
                    break;
                  }
                }
              });
            }

            bool _arePinsMatching() {
              if (_pin.length != _confirmPin.length) return false;
              for (int i = 0; i < _pin.length; i++) {
                if (_pin[i] != _confirmPin[i]) {
                  return false;
                }
              }
              return true;
            }

            return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Confirm transaction pin',
                            style: GoogleFonts.dmSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                width: 60,
                                height: 60,
                                child: Center(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _confirmPin[index].isEmpty ? Colors.grey : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 12,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (context, index) {
                              if (index == 9) {
                                return GestureDetector(
                                  onTap: _removeLastDigit,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.backspace),
                                  ),
                                );
                              } else if (index == 10) {
                                return GestureDetector(
                                  onTap: () {
                                    _addDigit(0);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFa5b4fc),
                                      borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              } else if (index == 11) {
                                return GestureDetector(
                                  onTap: () {
                                    if (_pin.every((digit) => digit.isNotEmpty) &&
                                        _confirmPin.every((digit) => digit.isNotEmpty)) {
                                      Navigator.pop(context);
                                      if (_arePinsMatching()) {
                                        pushPin(widget.user["uniqueId"], _pin.join());
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text('It appears your pins do not match, please try again..'),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    _addDigit(index + 1);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFa5b4fc),
                                      borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
          },
        );
      },
    );
  }

  //change transaction pin
  void _showBottomSheetForOldPin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _addDigit(int digit) {
              setState(() {
                for (int i = 0; i < _oldPin.length; i++) {
                  if (_oldPin[i].isEmpty) {
                    _oldPin[i] = digit.toString();
                    break;
                  }
                }
              });
            }

            void _removeLastDigit() {
              setState(() {
                for (int i = _oldPin.length - 1; i >= 0; i--) {
                  if (_oldPin[i].isNotEmpty) {
                    _oldPin[i] = '';
                    break;
                  }
                }
              });
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter your old transaction pin',
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: 60,
                        height: 60,
                        child: Center(
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _oldPin[index].isEmpty ? Colors.grey : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: 12,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.5,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 9) {
                        return GestureDetector(
                          onTap: _removeLastDigit,
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(Icons.backspace),
                          ),
                        );
                      } else if (index == 10) {
                        return GestureDetector(
                          onTap: () {
                            _addDigit(0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFa5b4fc),
                              borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '0',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      } else if (index == 11) {
                        return GestureDetector(
                          onTap: () {
                            if (_oldPin.every((digit) => digit.isNotEmpty)) {
                              Navigator.pop(context);
                              oldPinUpdate = _oldPin.join();
                              _showBottomSheetForNewPin(context);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            _addDigit(index + 1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFa5b4fc),
                              borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  void _showBottomSheetForNewPin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _addDigit(int digit) {
              setState(() {
                for (int i = 0; i < _newPin.length; i++) {
                  if (_newPin[i].isEmpty) {
                    _newPin[i] = digit.toString();
                    break;
                  }
                }
              });
            }

            void _removeLastDigit() {
              setState(() {
                for (int i = _newPin.length - 1; i >= 0; i--) {
                  if (_newPin[i].isNotEmpty) {
                    _newPin[i] = '';
                    break;
                  }
                }
              });
            }

            return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Enter your new transaction pin',
                            style: GoogleFonts.dmSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                width: 60,
                                height: 60,
                                child: Center(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _newPin[index].isEmpty ? Colors.grey : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 12,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (context, index) {
                              if (index == 9) {
                                return GestureDetector(
                                  onTap: _removeLastDigit,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.backspace),
                                  ),
                                );
                              } else if (index == 10) {
                                return GestureDetector(
                                  onTap: () {
                                    _addDigit(0);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFa5b4fc),
                                      borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              } else if (index == 11) {
                                return GestureDetector(
                                  onTap: () {
                                    if (_newPin.every((digit) => digit.isNotEmpty)) {
                                      Navigator.pop(context);
                                      _showBottomSheetForConfirmNewPin(context);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    _addDigit(index + 1);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFa5b4fc),
                                      borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
          },
        );
      },
    );
  }
  void _showBottomSheetForConfirmNewPin(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            void _addDigit(int digit) {
              setState(() {
                for (int i = 0; i < _confirmNewPin.length; i++) {
                  if (_confirmNewPin[i].isEmpty) {
                    _confirmNewPin[i] = digit.toString();
                    break;
                  }
                }
              });
            }

            void _removeLastDigit() {
              setState(() {
                for (int i = _confirmNewPin.length - 1; i >= 0; i--) {
                  if (_confirmNewPin[i].isNotEmpty) {
                    _confirmNewPin[i] = '';
                    break;
                  }
                }
              });
            }

            bool _arePinsMatching() {
              if (_newPin.length != _confirmNewPin.length) return false;
              for (int i = 0; i < _newPin.length; i++) {
                if (_newPin[i] != _confirmNewPin[i]) {
                  return false;
                }
              }
              return true;
            }

            return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Confirm your new transaction pin',
                            style: GoogleFonts.dmSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                width: 60,
                                height: 60,
                                child: Center(
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _confirmNewPin[index].isEmpty ? Colors.grey : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 12,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1.5,
                            ),
                            itemBuilder: (context, index) {
                              if (index == 9) {
                                return GestureDetector(
                                  onTap: _removeLastDigit,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.backspace),
                                  ),
                                );
                              } else if (index == 10) {
                                return GestureDetector(
                                  onTap: () {
                                    _addDigit(0);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFa5b4fc),
                                      borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              } else if (index == 11) {
                                return GestureDetector(
                                  onTap: () {
                                    if (_newPin.every((digit) => digit.isNotEmpty) &&
                                        _confirmNewPin.every((digit) => digit.isNotEmpty)) {
                                      Navigator.pop(context);
                                      if (_arePinsMatching()) {
                                        updatePin(widget.user["uniqueId"], oldPinUpdate, _newPin.join());
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text('New pins do not match, please try again..'),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    _addDigit(index + 1);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFa5b4fc),
                                      borderRadius: BorderRadius.circular(15), // Adjust the value for desired roundness
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
          },
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction pin',
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF3730a3),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.security,
                    color: Color(0xFF6366f1),
                  ),
                  title: Text(
                    'Create new transaction pin',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    _showBottomSheetPin(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 1,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.password,
                    color: Color(0xFF6366f1),
                  ),
                  title: Text(
                    'Change transaction pin',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    _showBottomSheetForOldPin(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 1,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(
                    Icons.lock_reset,
                    color: Color(0xFF6366f1),
                  ),
                  title: Text(
                    'Reset transaction pin',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    resetTransactionPin(widget.user["uniqueId"]);
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          if (_isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10,),
                Text("Encrypting transaction pin, please wait", style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600),)
              ],
              ),
            ),
        ],
      )
    );
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.lock_clock, color: Colors.white),
          SizedBox(width: 5,),
          Text(message, style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white
          ),)
        ],
      ),
      backgroundColor: Color(0xFF3730a3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> pushPin(String uniqueId, String pin) async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = 'https://www.lotusgoldmarkets.co/api/push-transaction-pin';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'uniqueId': uniqueId,
        'item': pin,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {

      final responseData = jsonDecode(response.body);
      print(responseData);
      final user = responseData["user"];
      // setState(() {
      //   isLoading = false;
      // });

      // Navigate to Home page and pass the user object
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(user: user),
        ),
      );
    } else {
      // Login failed
      final data = json.decode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data["message"]),
        backgroundColor: Colors.red,
      ));
      Navigator.pop(context);
    }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(user: widget.user),
        ),
      );
      // setState(() {
      //   isLoading = false;
      // });
    }

  Future<void> updatePin(String uniqueId, String oldPin, String newPin) async {
    print(oldPinUpdate);
    print(newPin);
    setState(() {
      _isLoading = true;
    });

    final String apiUrl = 'https://www.lotusgoldmarkets.co/api/update-transaction-pin';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'uniqueId': uniqueId,
        'oldItem': oldPin,
        'newItem' : newPin
      }),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {

      final responseData = jsonDecode(response.body);
      print(responseData);
      final user = responseData["user"];
      // setState(() {
      //   isLoading = false;
      // });

      // Navigate to Home page and pass the user object
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(user: user),
        ),
      );
    } else {
      // Login failed
      final data = json.decode(response.body);
      print(data);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data["message"]),
        backgroundColor: Colors.red,
      ));
      Navigator.pop(context);
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNav(user: widget.user),
      ),
    );
    // setState(() {
    //   isLoading = false;
    // });
  }

  void resetTransactionPin(String uniqueId) async {

    final response = await http.get(Uri.parse('https://www.lotusgoldmarkets.co/api/reset-trsansaction-pin/${widget.user["uniqueId"]}')); // Replace with your API endpoint

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      // Handle the response data
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pin reset mail sent to your registered email address.'),
        backgroundColor: Color(0xFF3730a3),
      ));
    } else {
      final data = json.decode(response.body);
      print(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(data["message"]),
        backgroundColor: Colors.red,
      ));
      Navigator.pop(context);
    }
  }




}
