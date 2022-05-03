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

  static String productsQuery = """
     query products(\$categoryId: String!){
        products(categoryId: \$categoryId){
            productId
            name
            price
            discount
            description
            categoryId
            subCategoryId
            unitsSold
            createdAt
            images{
                url
            }
        }
    }
""";

  static String createOrderQuery = """
     mutation createOrder(\$input: OrderInput!){
        createOrder(input: \$input){
            orderId
            orderNumber
            deliveryDate
        }
    }
""";
}
