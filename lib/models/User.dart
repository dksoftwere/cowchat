
class User {
   String? id;
   String ?fullName;
   String? phone;
   String? email;
   String ?dob;
   String? gender;
   String? address;
   String? qualification;
   String? userRole;
  User(this.id, this.fullName,this.phone, this.email,this.dob,this.gender,this.address,this.qualification, this.userRole);
  User.fromJson(Map<String, dynamic> data){
    id = data['id']?.toString();
    fullName = data['fullName']?.toString();
    phone = data['phone']?.toString();
    email = data['email']?.toString();
    dob = data['dob']?.toString();
    gender = data['gender']?.toString();
    address = data['address']?.toString();
    qualification = data['qualification']?.toString();
    userRole = data['userRole']?.toString();
  }

   Map<String, dynamic> toJson() {
     final data = <String, dynamic>{};
     data['id'] = id;
     data['fullName'] = fullName;
     data['phone'] = phone;
     data['email'] = email;
     data['dob'] = dob;
     data['gender'] = gender;
     data['address'] = address;
     data['qualification'] = qualification;
     data['userRole'] = userRole;
     return data;
   }

}