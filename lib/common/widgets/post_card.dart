import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String email;
  final String text;
  final String cinsiyet;
  final String formattedTime;
  final String formattedDate;

  const PostCard(
      {Key? key,
      required this.username,
      required this.email,
      required this.text,
      required this.cinsiyet,
      required this.formattedTime,
      required this.formattedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff20AE67),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage(cinsiyet == 'Erkek'
                              ? 'assets/erkek.png'
                              : 'assets/kadin.png'),
                          fit: BoxFit.cover)),
                ),
                /* CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(cinsiyet == 'Erkek'
                      ? 'assets/erkek.png'
                      : 'assets/kadin.png'),
                  radius: 30,
                ), */

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$formattedDate  $formattedTime',
                        style: TextStyle(fontSize: 13, color: Colors.black38),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              text,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 8.0),
            Text(
              '$email',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 8.0),
            const Divider(),
            Row(
              children: [
                Icon(
                  Icons.reply,
                  color: Colors.transparent.withOpacity(0.4),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  width: 40,
                ),
                Icon(
                  Icons.chat_bubble,
                  color: Colors.transparent.withOpacity(0.4),
                ),
                const SizedBox(
                  width: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 195,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.favorite),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
