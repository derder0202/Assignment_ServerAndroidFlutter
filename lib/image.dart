
class ImageModel{
  String? id = '';
  String? title,description,url,sdUrl;
  ImageModel(this.id,this.title, this.description, this.url, this.sdUrl);

  ImageModel.create(this.title, this.description);

  factory ImageModel.fromJson(Map<String,dynamic> json) => ImageModel(
       json['_id'],
       json['title'],
       json['description'],
       json['url'],
       json['sdUrl']
  );
  Map<String,dynamic> toJson() =>{
    "title": title,
    "description": description,
  };
}