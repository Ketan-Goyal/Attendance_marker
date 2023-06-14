class UserModel{
  final String uid;
  final String name;
  final String email;
  final String totalPresents;
  final String absents;
  final String leaves;

  UserModel(
      this.uid,
      this.name,
      this.email,
      this.totalPresents,
      this.absents,
      this.leaves
      );

  Map<String,dynamic> toJson()=>{
    "uid":uid,
    "name":name,
    "email":email,
    "totalPresents":totalPresents,
    "absents":absents,
    "leaves":leaves,
  };
}