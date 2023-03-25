import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/size_manger.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/constant/them.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/acitonforwating.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/screen/admin/admin_home.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/fromattime.dart';
import 'package:suuuuuuuuuuuuuuuuuuu/widgets/navigagton.dart';

class Wating extends StatelessWidget {
  const Wating({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: current,
        child: SafeArea(
            child: Scaffold(
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Watting')
                  .orderBy(
                    'datetime',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff8A02AE),
                    ),
                  );
                } else {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return Column(
                      children: [
                        const Head(
                          text: 'Wating Products',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              var snap = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: DilagItem(snap: snap),
                                        backgroundColor:
                                            Colors.purple.withOpacity(0.4),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        title: Center(
                                          child: Text(
                                            '${snap['orderNumber']}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 30),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.purple.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          '${snap['orderNumber']}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28),
                                        ),
                                      ),
                                      ItemForList(
                                        bodyText: '${snap['Adress1']}',
                                        heatText: 'AdressLine1: ',
                                      ),
                                      ItemForList(
                                        bodyText: '${snap['Adress2']}',
                                        heatText: 'AdressLine2: ',
                                      ),
                                      ItemForList(
                                        bodyText: '${snap['LensesType']}',
                                        heatText: 'LensesType: ',
                                      ),
                                      ItemForList(
                                        bodyText: '${snap['Optical']}',
                                        heatText: 'Optical: ',
                                      ),
                                      ItemForList(
                                        bodyText: '${snap['Code']}',
                                        heatText: 'Code: ',
                                      ),
                                      ItemForList(
                                        bodyText: '${snap['totalprice']}',
                                        heatText: 'totalprice: ',
                                      ),
                                      ItemForList(
                                        //
                                        bodyText: getTimeDifferenceFromNow(
                                            snap['datetime'].toDate(), true),
                                        heatText: 'sending From: ',
                                      ),
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child:
                                              Image.network(snap['LensSize'])),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Container(
                              width: double.infinity,
                              color: Colors.grey.shade400,
                              height: 1,
                            ),
                            itemCount: snapshot.data!.docs.length,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No Product in Watting',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.purple),
                      ),
                    );
                  }
                }
              }),
        )));
  }
}

class DilagItem extends StatelessWidget {
  final Map<String, dynamic> snap;
  const DilagItem({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(
                AppSizes.getWidth(context, 40),
                AppSizes.getHight(context, 30))),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            navigtonto(
                context,
                AcitonForWating(
                  head: '${snap['orderNumber']}',
                  snap: snap,
                  isConfirm: false,
                ));
          },
          label: const Text(
            'Reject ',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          icon: const Icon(
            Icons.delete_sharp,
            color: Colors.white,
            size: 25,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        TextButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            navigtonto(
                context,
                AcitonForWating(
                  head: '${snap['orderNumber']}',
                  snap: snap,
                  isConfirm: true,
                ));
          },
          label: const Text(
            'Confirm',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          icon: const Icon(
            Icons.done,
            color: Colors.white,
            size: 25,
          ),
        ),
      ],
    );
  }
}

class ItemForList extends StatelessWidget {
  final String heatText;
  final String bodyText;
  const ItemForList(
      {super.key, required this.bodyText, required this.heatText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: heatText,
                style: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              TextSpan(
                text: bodyText,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              )
            ],
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.purple.shade800,
        )
      ],
    );
  }
}
