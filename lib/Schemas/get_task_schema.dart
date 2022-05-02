class GetSchema {
  static String getProductsQuery = '''
query{
  categories
  {
    categoryId
    name
    products{
      name
      price
      description
      categoryId
      productId
      subCategoryId
      createdAt
      images{
        url
      }
    }
  }
}''';
}
