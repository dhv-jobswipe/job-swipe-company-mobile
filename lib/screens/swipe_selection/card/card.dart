import 'package:flutter/material.dart';
import 'package:pbl5/models/company/company.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/routes.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard(
       {
        super.key,
        required this.user,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.userDetail,
          arguments: user.id,
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: user.avatar != null
                          ? NetworkImage(user.avatar!)
                          : AssetImage('assets/images/company_placeholder.png')
                      as ImageProvider<Object>,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  (user.lastName ?? '') + " " + (user.firstName ?? ''),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.summaryIntroduction ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Text(
                  //   company.systemRole?.constantName ?? '',
                  //   style: const TextStyle(color: Colors.grey),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

