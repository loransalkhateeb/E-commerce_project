import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../providers/categories_prov.dart';
import 'addCategories.dart';

class categoriesAdmin extends StatefulWidget {
  const categoriesAdmin({Key? key}) : super(key: key);

  @override
  State<categoriesAdmin> createState() => _categoriesAdminState();
}


class _categoriesAdminState extends State<categoriesAdmin> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProv>(context, listen: false).getCategoriesAdmin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<CategoryProv>(
          builder: (context, value, child){
            return ListView.builder(
                itemBuilder: (context,index){
                  return Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                ConsValues.BASEURL +
                                    value.listCategoriesModelAdmin[index].imageURL,
                                height: 200,
                                width: 200,
                                fit: BoxFit.fitWidth,
                              ),
                              const SizedBox(width: 20,),
                              Text(value.listCategoriesModelAdmin[index].name),
                              const SizedBox(width: 20,),
                              IconButton(onPressed: (){},
                                  icon: const Icon(Icons.edit),)

                            ],
                          )

                        ],

                    ),
                  );


            },
              itemCount: value.listCategoriesModelAdmin.length,
              scrollDirection: Axis.vertical,
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const addCategories();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}
