// model for information of all users
class Usermodel {
  final String? email;
  final String? name;
  final String? password;
  final String? phone;
  final String? address;

  const Usermodel({
    this.email,
    required this.name,
    required this.phone,
    required this.password,
    required this.address,
  });

  toJon(){
    return {
      "name" : name,
      "email": email,
      "phone":phone,
      "password": password,
      "address":address
    };
  }
}

// model of notes
class Notesmodel {
  final String? create_date;
  final String? color_id;
  final String? note_content;
  final String? note_title;
  final String? user;

  const Notesmodel({
    this.user,
    required this.color_id,
    required this.create_date,
    required this.note_content,
    required this.note_title,
  });

  toJon(){
    return {
      "Creation_Date" : create_date,
      "user": user ,
      "color_id": color_id,
      "note_title": note_title,
      "note_content":note_content
    };
  }
}


// model of event

// model of notes
// class Eventsmodel {
//   final String? create_date;
//   final String? color_id;
//   final String? note_content;
//   final String? note_title;
//   final String? user;

//   const Notesmodel({
//     this.user,
//     required this.color_id,
//     required this.create_date,
//     required this.note_content,
//     required this.note_title,
//   });

//   toJon(){
//     return {
//       "Creation_Date" : create_date,
//       "user": user ,
//       "color_id": color_id,
//       "note_title": note_title,
//       "note_content":note_content
//     };
//   }
// }

