import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supan/main.dart';

// class FeeManagementScreen extends StatefulWidget {
//   @override
//   _FeeManagementScreenState createState() => _FeeManagementScreenState();
// }
//
// class _FeeManagementScreenState extends State<FeeManagementScreen> {
//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;
//
//   List<Map<String, dynamic>> students = [];
//   Map<String, Map<String, dynamic>> feesMap = {};
//
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadStudentsAndFees();
//   }
//
//   Future<void> _loadStudentsAndFees() async {
//     setState(() => isLoading = true);
//     try {
//       final studentData = await supabase.from('students').select().order('name');
//       students = List<Map<String, dynamic>>.from(studentData);
//
//       final feeData = await supabase
//           .from('fees')
//           .select()
//           .eq('year', selectedYear)
//           .eq('month', selectedMonth);
//       feesMap.clear();
//       for (final fee in feeData) {
//         feesMap[fee['student_id']] = fee;
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load data: $e')));
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }
//
//   Future<void> _toggleFeeStatus(String studentId) async {
//     final currentFee = feesMap[studentId];
//     final newStatus = !(currentFee?['is_paid'] ?? false);
//
//     try {
//       if (currentFee == null) {
//         final insertResponse = await supabase.from('fees').insert({
//           'student_id': studentId,
//           'year': selectedYear,
//           'month': selectedMonth,
//           'amount': 0,
//           'is_paid': newStatus,
//           'paid_at': newStatus ? DateTime.now().toUtc().toIso8601String() : null,
//         }).select();
//
//         feesMap[studentId] = insertResponse[0];
//       } else {
//         await supabase.from('fees').update({
//           'is_paid': newStatus,
//           'paid_at': newStatus ? DateTime.now().toUtc().toIso8601String() : null,
//         }).eq('id', currentFee['id']);
//         feesMap[studentId]!['is_paid'] = newStatus;
//       }
//       setState(() {});
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update fee: $e')));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final monthName = DateFormat.MMMM().format(DateTime(selectedYear, selectedMonth));
//     return Scaffold(
//       appBar: AppBar(title: Text('Fees for $monthName, $selectedYear')),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 DropdownButton<int>(
//                   value: selectedYear,
//                   items: List.generate(5, (index) {
//                     int year = DateTime.now().year - 2 + index;
//                     return DropdownMenuItem(value: year, child: Text(year.toString()));
//                   }),
//                   onChanged: (val) {
//                     if (val != null) {
//                       setState(() => selectedYear = val);
//                       _loadStudentsAndFees();
//                     }
//                   },
//                 ),
//                 SizedBox(width: 20),
//                 DropdownButton<int>(
//                   value: selectedMonth,
//                   items: List.generate(12, (index) {
//                     int month = index + 1;
//                     return DropdownMenuItem(value: month, child: Text(DateFormat.MMMM().format(DateTime(0, month))));
//                   }),
//                   onChanged: (val) {
//                     if (val != null) {
//                       setState(() => selectedMonth = val);
//                       _loadStudentsAndFees();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//               itemCount: students.length,
//               itemBuilder: (context, index) {
//                 final student = students[index];
//                 final fee = feesMap[student['id']];
//                 final isPaid = fee?['is_paid'] ?? false;
//
//                 return Card(
//                   color: isPaid ? Colors.green[100] : Colors.red[100],
//                   margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   child: ListTile(
//                     title: Text(student['name'] ?? ''),
//                     subtitle: Text('Roll: ${student['roll'] ?? ''} | Section: ${student['section'] ?? ''} | Class: ${student['class'] ?? ''}'),
//                     trailing: DropdownButton<String>(
//                       value: isPaid ? 'Paid' : 'Due',
//                       items: ['Paid', 'Due'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//                       onChanged: (val) {
//                         if (val != null) _toggleFeeStatus(student['id']);
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

final supabase = Supabase.instance.client;

class FeeManagementScreen extends StatefulWidget {
  @override
  _FeeManagementScreenState createState() => _FeeManagementScreenState();
}

class _FeeManagementScreenState extends State<FeeManagementScreen> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  List<Map<String, dynamic>> students = [];
  Map<String, Map<String, dynamic>> feesMap = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadStudentsAndFees();
  }

  Future<void> _loadStudentsAndFees() async {
    setState(() => isLoading = true);
    try {
      final studentData = await supabase.from('students').select().order('name');
      students = List<Map<String, dynamic>>.from(studentData);

      final feeData = await supabase
          .from('fees')
          .select()
          .eq('year', selectedYear)
          .eq('month', selectedMonth);
      feesMap.clear();
      for (final fee in feeData) {
        feesMap[fee['student_id']] = fee;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load data: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _toggleFeeStatus(String studentId) async {
    final currentFee = feesMap[studentId];
    final newStatus = !(currentFee?['is_paid'] ?? false);

    try {
      if (currentFee == null) {
        final insertResponse = await supabase.from('fees').insert({
          'student_id': studentId,
          'year': selectedYear,
          'month': selectedMonth,
          'amount': 0,
          'is_paid': newStatus,
          'paid_at': newStatus ? DateTime.now().toUtc().toIso8601String() : null,
        }).select();

        feesMap[studentId] = insertResponse[0];
      } else {
        await supabase.from('fees').update({
          'is_paid': newStatus,
          'paid_at': newStatus ? DateTime.now().toUtc().toIso8601String() : null,
        }).eq('id', currentFee['id']);
        feesMap[studentId]!['is_paid'] = newStatus;
      }
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update fee: $e')));
    }
  }

  // Show dialog to add a new student
  Future<void> _showAddStudentDialog() async {
    final _nameController = TextEditingController();
    final _rollController = TextEditingController();
    final _sectionController = TextEditingController();
    final _classController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Student'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _rollController,
                decoration: InputDecoration(labelText: 'Roll'),
              ),
              TextField(
                controller: _sectionController,
                decoration: InputDecoration(labelText: 'Section'),
              ),
              TextField(
                controller: _classController,
                decoration: InputDecoration(labelText: 'Class'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              final roll = _rollController.text.trim();
              final section = _sectionController.text.trim();
              final studentClass = _classController.text.trim();

              if (name.isEmpty || roll.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Name and Roll are required')));
                return;
              }

              try {
                final response = await supabase.from('students').insert({
                  'name': name,
                  'roll': roll,
                  'section': section,
                  'class': studentClass,
                }).select();

                if (response.isNotEmpty) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Student added successfully')));
                  _loadStudentsAndFees(); // Refresh list
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add student: $e')));
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final monthName = DateFormat.MMMM().format(DateTime(selectedYear, selectedMonth));

    return Scaffold(
      appBar: AppBar(
        title: Text('Fees for $monthName, $selectedYear'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add Student',
            onPressed: _showAddStudentDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                DropdownButton<int>(
                  value: selectedYear,
                  items: List.generate(5, (index) {
                    int year = DateTime.now().year - 2 + index;
                    return DropdownMenuItem(value: year, child: Text(year.toString()));
                  }),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => selectedYear = val);
                      _loadStudentsAndFees();
                    }
                  },
                ),
                SizedBox(width: 20),
                DropdownButton<int>(
                  value: selectedMonth,
                  items: List.generate(12, (index) {
                    int month = index + 1;
                    return DropdownMenuItem(value: month, child: Text(DateFormat.MMMM().format(DateTime(0, month))));
                  }),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => selectedMonth = val);
                      _loadStudentsAndFees();
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                final fee = feesMap[student['id']];
                final isPaid = fee?['is_paid'] ?? false;

                return Card(
                  color: isPaid ? Colors.green[100] : Colors.red[100],
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(student['name'] ?? ''),
                    subtitle: Text(
                      'Roll: ${student['roll'] ?? ''} | Section: ${student['section'] ?? ''} | Class: ${student['class'] ?? ''}',
                    ),
                    trailing: DropdownButton<String>(
                      value: isPaid ? 'Paid' : 'Due',
                      items: ['Paid', 'Due'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (val) {
                        if (val != null) _toggleFeeStatus(student['id']);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
