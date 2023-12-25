import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data.dart';
import 'all_operations_list.dart';
import 'operation_search.dart';

class AllOperationsBody extends StatefulWidget {
  const AllOperationsBody({super.key});

  @override
  State<AllOperationsBody> createState() => _AllOperationsBodyState();
}

class _AllOperationsBodyState extends State<AllOperationsBody> {
  late Future _allOperationsList;

  Future _getAllOperations() async {
    final provider = Provider.of<OperationsProvider>(context, listen: false);
    return provider.getOperations();
  }

  @override
  void initState() {
    super.initState();
    _allOperationsList = _getAllOperations();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) {
        Provider.of<OperationsProvider>(context, listen: false).searchText = "";
      },
      child: FutureBuilder(
        future: _allOperationsList,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                print(
                    "error:${snapshot.error} stackTrace:${snapshot.stackTrace}");
              }
              return Center(child: Text("${snapshot.error}"));
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    OperationSearch(),
                    Expanded(child: AllOperationsList()),
                  ],
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
