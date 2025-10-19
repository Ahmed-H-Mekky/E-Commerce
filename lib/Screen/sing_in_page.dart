import 'package:e_commerce/model/map_country.dart';
import 'package:e_commerce/widget/custom_drop_down_button_field.dart';
import 'package:e_commerce/widget/custom_text_field_signin.dart';
import 'package:e_commerce/widget/custom_botton.dart';
import 'package:e_commerce/widget/loading_page.dart';
import 'package:flutter/material.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});
  static const String id = 'SingInPage';
  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  TextEditingController numberPhon = TextEditingController();
  TextEditingController codeCountry = TextEditingController();
  String? code = 'مصر';
  bool isloading = false;
  @override
  void dispose() {
    numberPhon.dispose();
    codeCountry.dispose();
    super.dispose();
  }

  void setLoading(bool value) {
    setState(() {
      isloading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('تسجيل الدخول'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 90),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomDropDownButtonField(
                          initialValue: code,
                          onchange: (value) {
                            if (value != null) {
                              setState(() {
                                codeCountry.text = countryCodes[value]!;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: CustomtextFieldSignin(
                          textInputType: null,
                          textEditingController: codeCountry,
                          texthint: const Text(''),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomtextFieldSignin(
                    textInputType: TextInputType.number,
                    textEditingController: numberPhon,
                    texthint: const Text('ادخل رقم الهاتف'),
                  ),
                ),
              ],
            ),
            if (isloading)
              Container(
                color: Colors.black.withValues(alpha: 0.4),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 7, 73, 255),
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
          child: CustomBotton(
            onpressed: isloading
                ? null
                : () {
                    LoadingPage.loading(
                      context: context,
                      countryCode: codeCountry,
                      phoneNumber: numberPhon,
                      setloading: setLoading,
                    );
                  },
            text: const Text('التالي'),
            backgroundColor: Colors.amber,
            icon: null,
            iconColor: null,
          ),
        ),
      ),
    );
  }
}
