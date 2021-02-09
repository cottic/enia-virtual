import 'package:flutter/material.dart';

import 'chat_list.dart';
import '../components/adaptive_page_layout.dart';
import '../components/dialogs/simple_dialogs.dart';
import '../components/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

class EniaMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptivePageLayout(
      primaryPage: FocusPage.SECOND,
      firstScaffold: ChatList(),
      secondScaffold: EniaMenu(),
    );
  }
}

class EniaMenu extends StatefulWidget {
  @override
  _EniaMenuState createState() => _EniaMenuState();
}

class _EniaMenuState extends State<EniaMenu> {
  Future<dynamic> profileFuture;
  dynamic profile;
  Future<bool> crossSigningCachedFuture;
  bool crossSigningCached;
  Future<bool> megolmBackupCachedFuture;
  bool megolmBackupCached;
  String bullet = '\u2022';

  final _formKey = GlobalKey<FormBuilderState>();

  var genderOptions = ['Male', 'Female', 'Other'];

  Future<void> requestSSSSCache(BuildContext context) async {
    final handle = Matrix.of(context).client.encryption.ssss.open();
    final str = await SimpleDialogs(context).enterText(
      titleText: L10n.of(context).askSSSSCache,
      hintText: L10n.of(context).passphraseOrKey,
      password: true,
    );
    if (str != null) {
      SimpleDialogs(context).showLoadingDialog(context);
      // make sure the loading spinner shows before we test the keys
      await Future.delayed(Duration(milliseconds: 100));
      var valid = false;
      try {
        handle.unlock(recoveryKey: str);
        valid = true;
      } catch (_) {
        try {
          handle.unlock(passphrase: str);
          valid = true;
        } catch (_) {
          valid = false;
        }
      }
      await Navigator.of(context)?.pop();
      if (valid) {
        await handle.maybeCacheAll();
        await SimpleDialogs(context).inform(
          contentText: L10n.of(context).cachedKeys,
        );
        setState(() {
          crossSigningCachedFuture = null;
          crossSigningCached = null;
          megolmBackupCachedFuture = null;
          megolmBackupCached = null;
        });
      } else {
        await SimpleDialogs(context).inform(
          contentText: L10n.of(context).incorrectPassphraseOrKey,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final client = Matrix.of(context).client;
    profileFuture ??= client.ownProfile.then((p) {
      if (mounted) setState(() => profile = p);
      return p;
    });
    crossSigningCachedFuture ??=
        client.encryption.crossSigning.isCached().then((c) {
      if (mounted) setState(() => crossSigningCached = c);
      return c;
    });
    megolmBackupCachedFuture ??=
        client.encryption.keyManager.isCached().then((c) {
      if (mounted) setState(() => megolmBackupCached = c);
      return c;
    });
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: true,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'enia@virtual',
                style: TextStyle(color: Theme.of(context).backgroundColor),
              ),
              /*  background:  
              ContentBanner(
                profile?.avatarUrl,
                
                height: 300,
                //defaultIcon: Icons.account_circle,
                loading: profile == null,
                //onEdit: () => setAvatarAction(context),
              ), */
            ),
          ),
        ],
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          children: <Widget>[
            ListTile(
              title: Text(
                  'A partir de una mirada integral e intersectorial buscamos prevenir los embarazos no intencionales en la adolescencia. Los Ministerios Nacionales de Salud, de Desarrollo Social y de Educación, trabajamos en conjunto para garantizar los derechos de los y las adolescentes al acceso gratuito de métodos anticonceptivos, la educación sexual integral y asesorías en las escuelas, la consejería en salud sexual y reproductiva y actividades de promoción comunitarias.'),
            ),
            Divider(thickness: 1),
            ListTile(
              title: Text(
                '¿Qué nos proponemos?',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(bullet +
                  ' Sensibilizar sobre la importancia de prevenir el embarazo no intencional en la adolescencia.'),
            ),
            ListTile(
              title: Text(bullet +
                  ' Potenciar el ejercicio de los derechos sexuales y reproductivos en la adolescencia.'),
            ),
            ListTile(
              title: Text(bullet +
                  ' Brindar información sobre salud sexual y reproductiva y métodos anticonceptivos en forma gratuita en los servicios de salud.'),
            ),
            ListTile(
              title: Text(bullet +
                  ' Fortalecer políticas para la prevención del abuso, la violencia sexual y el acceso a la interrupción legal del embarazo según el marco normativo vigente.'),
            ),
            FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: <Widget>[
                  FormBuilderFilterChip(
                    spacing: 10.0,

                    // labelPadding: EdgeInsets.all(8.0),
                    name: 'filter_chip',
                    decoration: InputDecoration(
                      labelText: 'Select many options',
                    ),
                    options: [
                      FormBuilderFieldOption(
                          value: 'Test', child: Text('Test')),
                      FormBuilderFieldOption(
                          value: 'Test 1', child: Text('Test 1')),
                      FormBuilderFieldOption(
                          value: 'Test 2', child: Text('Test 2')),
                      FormBuilderFieldOption(
                          value: 'Test 3', child: Text('Test 3')),
                      FormBuilderFieldOption(
                          value: 'Test 4', child: Text('Test 4')),
                    ],
                  ),
                  FormBuilderChoiceChip(
                    spacing: 10.0,
                    name: 'choice_chip',
                    decoration: InputDecoration(
                      labelText: 'Select an option',
                    ),
                    options: [
                      FormBuilderFieldOption(
                          value: 'Test', child: Text('Test')),
                      FormBuilderFieldOption(
                          value: 'Test 1', child: Text('Test 1')),
                      FormBuilderFieldOption(
                          value: 'Test 2', child: Text('Test 2')),
                      FormBuilderFieldOption(
                          value: 'Test 3', child: Text('Test 3')),
                      FormBuilderFieldOption(
                          value: 'Test 4', child: Text('Test 4')),
                    ],
                  ),
                  FormBuilderColorPickerField(
                    name: 'color_picker',
                    initialValue: Colors.yellow,
                    colorPickerType: ColorPickerType.MaterialPicker,
                    decoration: InputDecoration(labelText: 'Pick Color'),
                  ),
                  FormBuilderChipsInput(
                    decoration: InputDecoration(labelText: 'Chips'),
                    name: 'chips_test',
                    onChanged: (value) {},
                    initialValue: [
                      Contact('Andrew', 'stock@man.com',
                          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
                    ],
                    maxChips: 5,
                    findSuggestions: (String query) {
                      if (query.isNotEmpty) {
                        var lowercaseQuery = query.toLowerCase();
                        return contacts.where((profile) {
                          return profile.name
                                  .toLowerCase()
                                  .contains(query.toLowerCase()) ||
                              profile.email
                                  .toLowerCase()
                                  .contains(query.toLowerCase());
                        }).toList(growable: false)
                          ..sort((a, b) => a.name
                              .toLowerCase()
                              .indexOf(lowercaseQuery)
                              .compareTo(b.name
                                  .toLowerCase()
                                  .indexOf(lowercaseQuery)));
                      } else {
                        return const <Contact>[];
                      }
                    },
                    chipBuilder: (context, state, profile) {
                      return InputChip(
                        key: ObjectKey(profile),
                        label: Text(profile.name),
                        avatar: CircleAvatar(
                          backgroundImage: NetworkImage(profile.imageUrl),
                        ),
                        onDeleted: () => state.deleteChip(profile),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      );
                    },
                    suggestionBuilder: (context, state, profile) {
                      return ListTile(
                        key: ObjectKey(profile),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profile.imageUrl),
                        ),
                        title: Text(profile.name),
                        subtitle: Text(profile.email),
                        onTap: () => state.selectSuggestion(profile),
                      );
                    },
                  ),
                  FormBuilderDateTimePicker(
                    name: 'date',
                    // onChanged: (value){},
                    inputType: InputType.time,
                    decoration: InputDecoration(
                      labelText: 'Appointment Time',
                    ),
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    initialValue: DateTime.now(),
                    // enabled: true,
                  ),
                  FormBuilderDateRangePicker(
                    name: 'date_range',
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2030),
                    // format: DateFormat('yyyy-MM-dd'),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      labelText: 'Date Range',
                      helperText: 'Helper text',
                      hintText: 'Hint text',
                    ),
                  ),
                  FormBuilderSlider(
                    name: 'slider',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.min(context, 6),
                    ]),
                    onChanged: (value) {},
                    min: 0.0,
                    max: 10.0,
                    initialValue: 7.0,
                    divisions: 20,
                    activeColor: Colors.red,
                    inactiveColor: Colors.pink[100],
                    decoration: InputDecoration(
                      labelText: 'Number of things',
                    ),
                  ),
                  FormBuilderCheckbox(
                    name: 'accept_terms',
                    initialValue: false,
                    onChanged: (value) {},
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I have read and agree to the ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    validator: FormBuilderValidators.equal(
                      context,
                      true,
                      errorText:
                          'You must accept terms and conditions to continue',
                    ),
                  ),
                  FormBuilderTextField(
                    name: 'age',
                    decoration: InputDecoration(
                      labelText:
                          'This value is passed along to the [Text.maxLines] attribute of the [Text] widget used to display the hint text.',
                    ),
                    onChanged: (value) {},
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.max(context, 70),
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderDropdown(
                    name: 'gender',
                    decoration: InputDecoration(
                      labelText: 'Gender',
                    ),
                    // initialValue: 'Male',
                    allowClear: true,
                    hint: Text('Select Gender'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: genderOptions
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text('$gender'),
                            ))
                        .toList(),
                  ),
                  FormBuilderTypeAhead(
                    decoration: InputDecoration(
                      labelText: 'Country',
                    ),
                    name: 'country',
                    onChanged: (value) {},
                    itemBuilder: (context, country) {
                      return ListTile(
                        title: Text(country),
                      );
                    },
                    controller: TextEditingController(text: ''),
                    // initialValue: 'Uganda',
                    suggestionsCallback: (query) {
                      if (query.isNotEmpty) {
                        var lowercaseQuery = query.toLowerCase();
                        return allCountries.where((country) {
                          return country.toLowerCase().contains(lowercaseQuery);
                        }).toList(growable: true)
                          ..sort((a, b) => a
                              .toLowerCase()
                              .indexOf(lowercaseQuery)
                              .compareTo(
                                  b.toLowerCase().indexOf(lowercaseQuery)));
                      } else {
                        return allCountries;
                      }
                    },
                  ),

                  FormBuilderRadioGroup(
                    decoration:
                        InputDecoration(labelText: 'My chosen language'),
                    name: 'best_language',
                    onChanged: (value) {},
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                        .map((lang) => FormBuilderFieldOption(
                              value: lang,
                              child: Text('$lang'),
                            ))
                        .toList(growable: false),
                  ),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: 'Stepper'),
                    name: 'stepper',
                    initialValue: 10,
                    step: 1,
                    iconSize: 48.0,
                    addIcon: Icon(Icons.arrow_right),
                    subtractIcon: Icon(Icons.arrow_left),
                  ),
                  FormBuilderRating(
                    decoration: InputDecoration(labelText: 'Rate this form'),
                    name: 'rate',
                    iconSize: 32.0,
                    initialValue: 1.0,
                    max: 5.0,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _formKey.currentState.save();
                      if (_formKey.currentState.validate()) {
                        print(_formKey.currentState.value);
                      } else {
                        print("validation failed");
                      }
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _formKey.currentState.reset();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class Contact {
  final String name;
  final String email;
  final String imageUrl;

  const Contact(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}

const allCountries = [
  'Afghanistan',
  'Albania',
  'Algeria',
  'American Samoa',
  'Andorra',
  'Angola',
  'Anguilla',
  'Antarctica',
  'Antigua and Barbuda',
  'Argentina',
  'Armenia',
  'Aruba',
  'Australia',
  'Austria',
  'Azerbaijan',
  'Bahamas',
  'Bahrain',
  'Bangladesh',
  'Barbados',
  'Belarus',
  'Belgium',
  'Belize',
  'Benin',
  'Bermuda',
  'Bhutan',
  'Bolivia',
  'Bosnia and Herzegowina',
  'Botswana',
  'Bouvet Island',
  'Brazil',
  'British Indian Ocean Territory',
  'Brunei Darussalam',
  'Bulgaria',
  'Burkina Faso',
  'Burundi',
  'Cambodia',
  'Cameroon',
  'Canada',
  'Cape Verde',
  'Cayman Islands',
  'Central African Republic',
  'Chad',
  'Chile',
  'China',
  'Christmas Island',
  'Cocos (Keeling) Islands',
  'Colombia',
  'Comoros',
  'Congo',
  'Congo, the Democratic Republic of the',
  'Cook Islands',
  'Costa Rica',
  'Cote d\'Ivoire',
  'Croatia (Hrvatska)',
  'Cuba',
  'Cyprus',
  'Czech Republic',
  'Denmark',
  'Djibouti',
  'Dominica',
  'Dominican Republic',
  'East Timor',
  'Ecuador',
  'Egypt',
  'El Salvador',
  'Equatorial Guinea',
  'Eritrea',
  'Estonia',
  'Ethiopia',
  'Falkland Islands (Malvinas)',
  'Faroe Islands',
  'Fiji',
  'Finland',
  'France',
  'France Metropolitan',
  'French Guiana',
  'French Polynesia',
  'French Southern Territories',
  'Gabon',
  'Gambia',
  'Georgia',
  'Germany',
  'Ghana',
  'Gibraltar',
  'Greece',
  'Greenland',
  'Grenada',
  'Guadeloupe',
  'Guam',
  'Guatemala',
  'Guinea',
  'Guinea-Bissau',
  'Guyana',
  'Haiti',
  'Heard and Mc Donald Islands',
  'Holy See (Vatican City State)',
  'Honduras',
  'Hong Kong',
  'Hungary',
  'Iceland',
  'India',
  'Indonesia',
  'Iran (Islamic Republic of)',
  'Iraq',
  'Ireland',
  'Israel',
  'Italy',
  'Jamaica',
  'Japan',
  'Jordan',
  'Kazakhstan',
  'Kenya',
  'Kiribati',
  'Korea, Democratic People\'s Republic of',
  'Korea, Republic of',
  'Kuwait',
  'Kyrgyzstan',
  'Lao, People\'s Democratic Republic',
  'Latvia',
  'Lebanon'
  
];

const contacts = <Contact>[
  Contact('Andrew', 'stock@man.com',
      'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
  Contact('Paul', 'paul@google.com',
      'https://media.istockphoto.com/photos/man-with-crossed-arms-isolated-on-gray-background-picture-id1171169099'),
  Contact('Fred', 'fred@google.com',
      'https://media.istockphoto.com/photos/confident-businessman-posing-in-the-office-picture-id891418990'),
  Contact('Brian', 'brian@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('John', 'john@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Thomas', 'thomas@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Nelly', 'nelly@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Marie', 'marie@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Charlie', 'charlie@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Diana', 'diana@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Ernie', 'ernie@flutter.io',
      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
  Contact('Gina', 'gina@flutter.io',
      'https://media.istockphoto.com/photos/all-set-for-a-productive-night-ahead-picture-id637233964'),
];
