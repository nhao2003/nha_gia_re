import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nha_gia_re/modules/settings/settings_controller.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  final SettingsController _controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ngôn ngữ")),
      body: ListView.separated(
        itemCount: _controller.languages.length,
        itemBuilder: (context, index) {
          String language = _controller.languages.values.elementAt(index);
          String languageCode = _controller.languages.keys.elementAt(index);
          return ListTile(
            title: Text(language),
            trailing: Obx(() => Radio<String>(
              value: languageCode,
              groupValue: _controller.selectedLanguage.value,
              onChanged: (String? value) {},
            )),
            onTap: () {
              _controller.changeLocale(languageCode);
              _controller.selectedLanguage.value = languageCode;
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
} 