class CoursesModel
{
  String status;
  dynamic type;
  Result result;

  CoursesModel({this.status, this.type, this.result});

  CoursesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    type = json['type'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result
{
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Result(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Result.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data
{
  int id;
  String categoryId;
  String title;
  String slug;
  String description;
  String price;
  String courseImage;
  String startDate;
  String featured;
  String trending;
  String popular;
  Null metaTitle;
  Null metaDescription;
  Null metaKeywords;
  String published;
  String free;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String image;

  Data(
      {this.id,
        this.categoryId,
        this.title,
        this.slug,
        this.description,
        this.price,
        this.courseImage,
        this.startDate,
        this.featured,
        this.trending,
        this.popular,
        this.metaTitle,
        this.metaDescription,
        this.metaKeywords,
        this.published,
        this.free,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.image});

  Data.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    price = json['price'];
    courseImage = json['course_image'];
    startDate = json['start_date'];
    featured = json['featured'];
    trending = json['trending'];
    popular = json['popular'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    published = json['published'];
    free = json['free'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['price'] = this.price;
    data['course_image'] = this.courseImage;
    data['start_date'] = this.startDate;
    data['featured'] = this.featured;
    data['trending'] = this.trending;
    data['popular'] = this.popular;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keywords'] = this.metaKeywords;
    data['published'] = this.published;
    data['free'] = this.free;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['image'] = this.image;
    return data;
  }
}