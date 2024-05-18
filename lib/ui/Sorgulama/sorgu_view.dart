import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:yz_app_jam/ui/Sorgulama/sorgu_view_model.dart';
import 'package:yz_app_jam/ui/image_labeling/image_labeling_view.dart';

class SorguView extends StatelessWidget {
  const SorguView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SorguViewModel>.reactive(
        viewModelBuilder: () => SorguViewModel(),
        onViewModelReady: (viewModel) => viewModel.init(),
        builder: (context, viewModel, child) => Scaffold(
              backgroundColor: Color(0xff20AE67),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      height: 100,
                      width: 340,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 164, 244, 204),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset('assets/flower.png'),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              'Çiçek türünü öğrenmek ister misin? Hemen fotoğrafını çek ve yükle, sana türünü söyleyelim.',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => ImageLabelingView()),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_right,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      height: 100,
                      width: 340,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 164, 244, 204),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset('assets/manatar3.png'),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              'Merak ettiğin mantar türünü öğrenmek için bir adım at! Fotoğrafını çek ve biz de o gizemli dünyadan bilgi verelim',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_right,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      height: 100,
                      width: 340,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 164, 244, 204),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image.asset('assets/bitki.png'),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              'Bitkiler, doğanın sessiz kahramanlarıdır, gizemlerini keşfetmeye ne dersin?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_right,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
