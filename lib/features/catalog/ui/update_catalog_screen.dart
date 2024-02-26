import 'package:cinelog/features/catalog/bloc/catalog_bloc.dart';
import 'package:cinelog/features/catalog/model/catalog_model.dart';
import 'package:cinelog/features/home/ui/custom_app_bar.dart';
import 'package:cinelog/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateCatalogScreen extends StatelessWidget {
  final String currTitle;
  final String currDescription;
  final int index;
  UpdateCatalogScreen(
      {super.key,
      required this.currTitle,
      required this.currDescription,
      required this.index});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CatalogBloc catalogBloc = CatalogBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatalogBloc, CatalogState>(
      bloc: catalogBloc,
      listenWhen: (previous, current) => current is CatalogActionState,
      buildWhen: (previous, current) => current is! CatalogActionState,
      listener: (context, state) {
        if (state is CatalogUpdateCatalogButtonActionState) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (builder) => MainScreen(
                        index: 1,
                      )));
        }
      },
      builder: (context, state) {
        _titleController.text = currTitle;
        _descriptionController.text = currDescription;
        return Scaffold(
          body: SafeArea(
              child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "<- Back",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const Text("Update catalog",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Expanded(
                        child: const Divider(
                          thickness: 3,
                          color: Color(0xFFFF05454),
                        ),
                      ),
                      Expanded(
                        child: const Divider(
                          thickness: 3,
                          color: Color(0xFFFF30475E),
                        ),
                      ),
                      Expanded(
                        child: const Divider(
                          thickness: 3,
                          color: Color(0xFFFF222831),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        hintText: "Create a catalog title",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: "Create a catalog description",
                        border: OutlineInputBorder()),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        catalogBloc.add(CatalogUpdateCatalogButtonClickedEvent(
                            index: index,
                            catalog: catalogModelDatabase(
                                description: _descriptionController.text,
                                title: _titleController.text)));
                      },
                      child: Text("Selesai"))
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
