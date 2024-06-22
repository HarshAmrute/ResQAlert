import 'package:flutter/material.dart';

class FirstAidPage extends StatelessWidget {
  final List<FirstAidItem> firstAidItems = [
    FirstAidItem(
      title: 'Bleeding',
      description:
          '1. Apply direct pressure to the wound with a clean cloth.\n2. Elevate the wound above the heart if possible.\n3. Apply pressure until bleeding stops.\n4. If bleeding doesn\'t stop, seek medical help.',
    ),
    FirstAidItem(
      title: 'Choking',
      description:
          '1. Encourage the person to cough forcefully.\n2. Perform abdominal thrusts (Heimlich maneuver) if the person is unable to cough.\n3. Stand behind the person and wrap your arms around their waist.\n4. Make a fist with one hand and place it above the person\'s navel.\n5. Grasp the fist with your other hand and press into the abdomen with a quick upward thrust.\n6. Repeat until the object is dislodged or the person becomes unconscious.',
    ),
    FirstAidItem(
      title: 'Burns',
      description:
          '1. Remove the person from the source of the burn.\n2. Cool the burn with cool running water for at least 10 minutes.\n3. Remove clothing or jewelry from the burned area unless it\'s stuck to the skin.\n4. Cover the burn with a sterile gauze bandage or clean cloth.\n5. Seek medical help if the burn is severe or covers a large area of the body.',
    ),
    FirstAidItem(
      title: 'Fractures',
      description:
          '1. Immobilize the injured area by splinting.\n2. Apply ice packs to reduce swelling and pain.\n3. Seek medical help immediately.\n4. Do not attempt to realign the bone yourself.',
    ),
    FirstAidItem(
      title: 'Heat Stroke',
      description:
          '1. Move the person to a cooler place.\n2. Remove excess clothing.\n3. Apply cool water or ice packs to the skin.\n4. Fan the person to help them cool down.\n5. Seek medical help if the person\'s condition does not improve.',
    ),
    FirstAidItem(
      title: 'Heat Exhaustion',
      description:
          '1. Move the person to a cooler place.\n2. Have them lie down and elevate their feet.\n3. Remove excess clothing and apply cool compresses.\n4. Give them water to drink.\n5. Seek medical help if symptoms worsen or last longer than 1 hour.',
    ),
    FirstAidItem(
      title: 'Seizures',
      description:
          '1. Keep the person safe and remove any nearby objects that could cause harm.\n2. Place the person on their side to help keep their airway clear.\n3. Time the seizure.\n4. Stay with the person until the seizure ends.\n5. Comfort the person and reassure them once the seizure has ended.',
    ),
    FirstAidItem(
      title: 'Allergic Reactions (Anaphylaxis)',
      description:
          '1. Administer epinephrine if available (use an auto-injector if the person has one).\n2. Call emergency services.\n3. Lay the person down and elevate their legs.\n4. Keep the person warm.\n5. Monitor their vital signs until help arrives.',
    ),
    FirstAidItem(
      title: 'Heart Attack',
      description:
          '1. Call emergency services immediately.\n2. Have the person sit down and rest in a comfortable position.\n3. Loosen tight clothing and reassure the person.\n4. If the person is conscious, give them aspirin if available.\n5. Stay with the person until help arrives and monitor their condition.',
    ),
    FirstAidItem(
      title: 'Stroke',
      description:
          '1. Remember the acronym FAST: Face drooping, Arm weakness, Speech difficulty, Time to call emergency services.\n2. Call emergency services immediately.\n3. Keep the person calm and comfortable.\n4. Note the time when symptoms started.\n5. Reassure the person and stay with them until help arrives.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Aid'),
        backgroundColor: Colors.red, // Custom app bar color
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: firstAidItems.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4, // Add elevation for a card-like effect
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(
                  firstAidItems[index].title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red, // Custom title color
                  ),
                ),
                subtitle: Text(
                  firstAidItems[index].description,
                  maxLines: 2, // Limit to two lines of description
                  overflow:
                      TextOverflow.ellipsis, // Add ellipsis if text overflows
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirstAidDetailPage(
                        firstAidItem: firstAidItems[index],
                      ),
                    ),
                  );
                },
                trailing: Icon(Icons.arrow_forward,
                    color: Colors.red), // Add arrow icon with custom color
              ),
            );
          },
        ),
      ),
    );
  }
}

class FirstAidDetailPage extends StatelessWidget {
  final FirstAidItem firstAidItem;

  const FirstAidDetailPage({required this.firstAidItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(firstAidItem.title),
        backgroundColor: Colors.red, // Custom app bar color
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstAidItem.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Custom title color
              ),
            ),
            SizedBox(height: 16),
            Text(
              firstAidItem.description,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstAidItem {
  final String title;
  final String description;

  FirstAidItem({required this.title, required this.description});
}
